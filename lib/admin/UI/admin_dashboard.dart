import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../admin_api.dart';

class AdminDashboardPage extends StatefulWidget {
  const AdminDashboardPage({super.key});

  @override
  State<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  static const navy = Color(0xFF17223B);
  static const background = Color(0xFFF4F7FB);
  static const statuses = ['requested', 'pending', 'done'];
  static const roles = ['user', 'admin'];

  final _api = AdminAPI();
  ConfigurationSummary _summary = const ConfigurationSummary();
  List<AdminConfiguration> _configurations = [];
  List<AdminUser> _users = [];
  bool _loadingConfigurations = true;
  bool _loadingUsers = true;
  String? _configurationError;
  String? _userError;
  final Set<String> _updatingConfigurations = {};
  final Set<String> _updatingUsers = {};
  final Set<String> _deletingConfigurations = {};
  final Set<String> _deletingUsers = {};

  @override
  void initState() {
    super.initState();
    _guardAndLoad();
  }

  Future<void> _guardAndLoad() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('sessionID');
    final role = prefs.getString('role')?.toLowerCase();
    if (token == null || token.isEmpty) {
      return _redirectToLogin();
    }
    if (role != 'admin') {
      return _redirectForbidden();
    }
    await Future.wait([_loadConfigurations(), _loadUsers()]);
  }

  Future<void> _loadConfigurations() async {
    if (mounted) {
      setState(() {
        _loadingConfigurations = true;
        _configurationError = null;
      });
    }
    try {
      final result = await _api.getConfigurations();
      if (!mounted) return;
      setState(() {
        _summary = result.summary;
        _configurations = result.data;
        _loadingConfigurations = false;
      });
    } on AdminApiException catch (error) {
      if (await _handleAuthError(error)) return;
      if (mounted) {
        setState(() {
          _configurationError = error.message;
          _loadingConfigurations = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _configurationError = 'Unable to load configurations.';
          _loadingConfigurations = false;
        });
      }
    }
  }

  Future<void> _loadUsers() async {
    if (mounted) {
      setState(() {
        _loadingUsers = true;
        _userError = null;
      });
    }
    try {
      final users = await _api.getUsers();
      if (!mounted) return;
      setState(() {
        _users = users;
        _loadingUsers = false;
      });
    } on AdminApiException catch (error) {
      if (await _handleAuthError(error)) return;
      if (mounted) {
        setState(() {
          _userError = error.message;
          _loadingUsers = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _userError = 'Unable to load users.';
          _loadingUsers = false;
        });
      }
    }
  }

  Future<bool> _handleAuthError(AdminApiException error) async {
    if (error.unauthorized) {
      await _redirectToLogin();
      return true;
    }
    if (error.forbidden) {
      await _redirectForbidden();
      return true;
    }
    return false;
  }

  Future<void> _redirectToLogin() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('sessionID');
    await prefs.remove('role');
    await prefs.remove('username');
    if (mounted) {
      Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false);
    }
  }

  Future<void> _redirectForbidden() async {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Administrator access is required.'),
    ));
    Navigator.pushNamedAndRemoveUntil(context, '/dashboard', (_) => false);
  }

  Future<void> _changeStatus(
      AdminConfiguration configuration, String? status) async {
    if (status == null ||
        status == configuration.status ||
        _updatingConfigurations.contains(configuration.id)) {
      return;
    }
    setState(() => _updatingConfigurations.add(configuration.id));
    try {
      final returnedStatus =
          await _api.updateConfigurationStatus(configuration.id, status);
      if (!mounted) return;
      setState(() {
        configuration.status = returnedStatus;
        _recalculateSummary();
      });
      _message('Configuration status updated.');
    } on AdminApiException catch (error) {
      if (await _handleAuthError(error)) return;
      _message(error.message, error: true);
      if (error.statusCode == 404) await _loadConfigurations();
    } finally {
      if (mounted) {
        setState(() => _updatingConfigurations.remove(configuration.id));
      }
    }
  }

  Future<void> _changeRole(AdminUser user, String? role) async {
    if (role == null ||
        role == user.role ||
        _updatingUsers.contains(user.userID)) {
      return;
    }
    setState(() => _updatingUsers.add(user.userID));
    try {
      final returnedRole = await _api.updateUserRole(user.userID, role);
      if (!mounted) return;
      setState(() => user.role = returnedRole);
      _message('User role updated.');
    } on AdminApiException catch (error) {
      if (await _handleAuthError(error)) return;
      _message(error.message, error: true);
      if (error.statusCode == 404) await _loadUsers();
    } finally {
      if (mounted) {
        setState(() => _updatingUsers.remove(user.userID));
      }
    }
  }

  void _recalculateSummary() {
    _summary = ConfigurationSummary(
      total: _configurations.length,
      requested:
          _configurations.where((item) => item.status == 'requested').length,
      pending: _configurations.where((item) => item.status == 'pending').length,
      done: _configurations.where((item) => item.status == 'done').length,
    );
  }

  Future<void> _editConfiguration(AdminConfiguration configuration) async {
    final changes = await showDialog<Map<String, dynamic>>(
      context: context,
      barrierDismissible: false,
      builder: (_) => _EditConfigurationDialog(configuration: configuration),
    );
    if (changes == null) return;
    try {
      await _api.updateConfiguration(configuration.id, changes);
      await _loadConfigurations();
      _message('Configuration updated.');
    } on AdminApiException catch (error) {
      if (await _handleAuthError(error)) return;
      _message(error.message, error: true);
    }
  }

  Future<void> _deleteConfiguration(AdminConfiguration configuration) async {
    final confirmed = await _confirmDelete(
      title: 'Delete configuration?',
      message:
          '“${configuration.name}” and its configured products will be permanently deleted.',
    );
    if (!confirmed || !mounted) return;
    setState(() => _deletingConfigurations.add(configuration.id));
    try {
      await _api.deleteConfiguration(configuration.id);
      if (!mounted) return;
      setState(() {
        _configurations.removeWhere((item) => item.id == configuration.id);
        _recalculateSummary();
      });
      _message('Configuration deleted.');
    } on AdminApiException catch (error) {
      if (await _handleAuthError(error)) return;
      _message(error.message, error: true);
      if (error.statusCode == 404) await _loadConfigurations();
    } finally {
      if (mounted) {
        setState(() => _deletingConfigurations.remove(configuration.id));
      }
    }
  }

  Future<void> _editUser(AdminUser user) async {
    final changes = await showDialog<Map<String, dynamic>>(
      context: context,
      barrierDismissible: false,
      builder: (_) => _EditUserDialog(user: user, api: _api),
    );
    if (changes == null) return;
    try {
      await _api.updateUser(user.userID, changes);
      await _loadUsers();
      _message('User updated.');
    } on AdminApiException catch (error) {
      if (await _handleAuthError(error)) return;
      _message(error.message, error: true);
    }
  }

  void _viewUser(AdminUser user) {
    showDialog<void>(
        context: context, builder: (_) => _UserDetails(user: user));
  }

  Future<void> _deleteUser(AdminUser user) async {
    final confirmed = await _confirmDelete(
      title: 'Delete user?',
      message: '“${user.name}” (${user.username}) will be permanently deleted.',
    );
    if (!confirmed || !mounted) return;
    setState(() => _deletingUsers.add(user.userID));
    try {
      await _api.deleteUser(user.userID);
      if (!mounted) return;
      setState(() => _users.removeWhere((item) => item.userID == user.userID));
      _message('User deleted.');
    } on AdminApiException catch (error) {
      if (await _handleAuthError(error)) return;
      _message(error.message, error: true);
      if (error.statusCode == 404) await _loadUsers();
    } finally {
      if (mounted) setState(() => _deletingUsers.remove(user.userID));
    }
  }

  Future<bool> _confirmDelete(
      {required String title, required String message}) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            icon: const Icon(Icons.warning_amber_rounded,
                color: Colors.red, size: 42),
            title: Text(title, textAlign: TextAlign.center),
            content: Text(message, textAlign: TextAlign.center),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('Cancel')),
              FilledButton.icon(
                style: FilledButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () => Navigator.pop(context, true),
                icon: const Icon(Icons.delete_outline),
                label: const Text('Delete permanently'),
              ),
            ],
          ),
        ) ??
        false;
  }

  void _message(String message, {bool error = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: error ? Colors.red.shade700 : null,
    ));
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('sessionID');
    await prefs.remove('role');
    await prefs.remove('username');
    if (mounted) {
      Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: background,
        appBar: AppBar(
          toolbarHeight: 74,
          backgroundColor: navy,
          foregroundColor: Colors.white,
          title: Row(children: [
            SvgPicture.asset('assets/WhiteML_Logo-w-tag-vector.svg',
                height: 43),
            const SizedBox(width: 18),
            if (MediaQuery.sizeOf(context).width >= 620)
              const Text('Admin dashboard',
                  style: TextStyle(fontWeight: FontWeight.w700)),
          ]),
          actions: [
            IconButton(
              tooltip: 'User dashboard',
              onPressed: () => Navigator.pushNamed(context, '/dashboard'),
              icon: const Icon(Icons.person_outline),
            ),
            IconButton(
                tooltip: 'Logout',
                onPressed: _logout,
                icon: const Icon(Icons.logout)),
            const SizedBox(width: 8),
          ],
          bottom: const TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(icon: Icon(Icons.tune), text: 'Configurations'),
              Tab(icon: Icon(Icons.people_outline), text: 'Users'),
            ],
          ),
        ),
        body: TabBarView(children: [
          _configurationsTab(),
          _usersTab(),
        ]),
      ),
    );
  }

  Widget _configurationsTab() {
    if (_loadingConfigurations) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_configurationError != null) {
      return _ErrorView(
          message: _configurationError!, onRetry: _loadConfigurations);
    }
    final compact = _isCompactLayout();
    return RefreshIndicator(
      onRefresh: _loadConfigurations,
      child: ListView(padding: _pagePadding(), children: [
        _heading('Configurations', _loadConfigurations),
        const SizedBox(height: 18),
        _summaryCards(),
        const SizedBox(height: 22),
        compact
            ? _configurationCards()
            : _tableContainer(
                empty: _configurations.isEmpty,
                emptyText: 'No configurations found.',
                table: DataTable(
                  columnSpacing: _columnSpacing(),
                  horizontalMargin: 12,
                  headingRowHeight: 44,
                  dataRowMinHeight: 54,
                  dataRowMaxHeight: 58,
                  dividerThickness: .65,
                  columns: const [
                    DataColumn(label: Text('Configuration name')),
                    DataColumn(label: Text('Status')),
                    DataColumn(label: Text('Date ordered')),
                    DataColumn(label: Text('Completion date')),
                    DataColumn(label: Text('Products'), numeric: true),
                    DataColumn(label: Text('Details')),
                    DataColumn(label: Text('Change status')),
                    DataColumn(label: Text('Actions')),
                  ],
                  rows: _configurations.map(_configurationRow).toList(),
                ),
              ),
      ]),
    );
  }

  DataRow _configurationRow(AdminConfiguration item) => DataRow(cells: [
        DataCell(_responsiveText(item.name, .15, 130, 240)),
        DataCell(_StatusBadge(item.status)),
        DataCell(_responsiveText(_date(item.dateOrdered), .12, 125, 190)),
        DataCell(_responsiveText(_date(item.completeDate), .12, 125, 190)),
        DataCell(Text('${item.cart.length}')),
        DataCell(IconButton(
          tooltip: 'View details',
          onPressed: () => showDialog<void>(
              context: context,
              builder: (_) => _ConfigurationDetails(configuration: item)),
          icon: const Icon(Icons.visibility_outlined),
        )),
        DataCell(_updatingConfigurations.contains(item.id)
            ? const SizedBox.square(
                dimension: 22, child: CircularProgressIndicator(strokeWidth: 2))
            : DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: statuses.contains(item.status) ? item.status : null,
                  hint: Text(item.status),
                  items: statuses
                      .map((value) => DropdownMenuItem(
                          value: value, child: Text(_titleCase(value))))
                      .toList(),
                  onChanged: (value) => _changeStatus(item, value),
                ),
              )),
        DataCell(_deletingConfigurations.contains(item.id)
            ? const SizedBox.square(
                dimension: 22, child: CircularProgressIndicator(strokeWidth: 2))
            : Row(mainAxisSize: MainAxisSize.min, children: [
                IconButton(
                  tooltip: 'Edit configuration',
                  onPressed: () => _editConfiguration(item),
                  icon:
                      const Icon(Icons.edit_outlined, color: Color(0xFF2563EB)),
                ),
                IconButton(
                  tooltip: 'Delete configuration',
                  onPressed: () => _deleteConfiguration(item),
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                ),
              ])),
      ]);

  Widget _usersTab() {
    if (_loadingUsers) return const Center(child: CircularProgressIndicator());
    if (_userError != null) {
      return _ErrorView(message: _userError!, onRetry: _loadUsers);
    }
    final compact = _isCompactLayout();
    return RefreshIndicator(
      onRefresh: _loadUsers,
      child: ListView(padding: _pagePadding(), children: [
        _heading('Users (${_users.length})', _loadUsers),
        const SizedBox(height: 18),
        compact ? _userCards() : _usersTable(),
      ]),
    );
  }

  Widget _usersTable() => _tableContainer(
        empty: _users.isEmpty,
        emptyText: 'No users found.',
        table: DataTable(
          columnSpacing: _columnSpacing(),
          horizontalMargin: 12,
          headingRowHeight: 44,
          dataRowMinHeight: 54,
          dataRowMaxHeight: 58,
          dividerThickness: .65,
          columns: const [
            DataColumn(label: Text('Name')),
            DataColumn(label: Text('Username')),
            DataColumn(label: Text('Email')),
            DataColumn(label: Text('Phone')),
            DataColumn(label: Text('Company')),
            DataColumn(label: Text('Country')),
            DataColumn(label: Text('Role')),
            DataColumn(label: Text('Change role')),
            DataColumn(label: Text('Actions')),
          ],
          rows: _users
              .map((user) => DataRow(cells: [
                    DataCell(_responsiveText(user.name, .11, 100, 180)),
                    DataCell(_responsiveText(user.username, .13, 125, 210)),
                    DataCell(_responsiveText(user.email, .14, 135, 230)),
                    DataCell(_responsiveText(user.phone, .09, 100, 150)),
                    DataCell(_responsiveText(user.company, .12, 110, 200)),
                    DataCell(_responsiveText(user.country, .08, 80, 130)),
                    DataCell(_RoleBadge(user.role)),
                    DataCell(_userRoleControl(user)),
                    DataCell(_userActions(user)),
                  ]))
              .toList(),
        ),
      );

  Widget _configurationCards() {
    if (_configurations.isEmpty) {
      return _emptyCard('No configurations found.');
    }
    return Column(
      children: [
        for (final item in _configurations)
          _AdminListCard(
            margin: const EdgeInsets.only(bottom: 12),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Expanded(
                  child: Text(item.name,
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w800)),
                ),
                const SizedBox(width: 10),
                _StatusBadge(item.status),
              ]),
              const SizedBox(height: 12),
              _InfoLine(
                  icon: Icons.event_outlined,
                  label: 'Ordered',
                  value: _date(item.dateOrdered)),
              _InfoLine(
                  icon: Icons.event_available_outlined,
                  label: 'Complete',
                  value: _date(item.completeDate)),
              _InfoLine(
                  icon: Icons.inventory_2_outlined,
                  label: 'Products',
                  value: '${item.cart.length}'),
              const SizedBox(height: 12),
              _configurationStatusControl(item),
              const Divider(height: 24),
              Wrap(spacing: 4, runSpacing: 4, children: [
                IconButton.filledTonal(
                  tooltip: 'View details',
                  onPressed: () => showDialog<void>(
                      context: context,
                      builder: (_) =>
                          _ConfigurationDetails(configuration: item)),
                  icon: const Icon(Icons.visibility_outlined),
                ),
                IconButton.filledTonal(
                  tooltip: 'Edit configuration',
                  onPressed: () => _editConfiguration(item),
                  icon: const Icon(Icons.edit_outlined),
                ),
                IconButton.filledTonal(
                  tooltip: 'Delete configuration',
                  onPressed: _deletingConfigurations.contains(item.id)
                      ? null
                      : () => _deleteConfiguration(item),
                  icon: _deletingConfigurations.contains(item.id)
                      ? const SizedBox.square(
                          dimension: 18,
                          child: CircularProgressIndicator(strokeWidth: 2))
                      : const Icon(Icons.delete_outline, color: Colors.red),
                ),
              ]),
            ]),
          ),
      ],
    );
  }

  Widget _userCards() {
    if (_users.isEmpty) return _emptyCard('No users found.');
    return Column(
      children: [
        for (final user in _users)
          _AdminListCard(
            margin: const EdgeInsets.only(bottom: 12),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Expanded(
                  child: Text(user.name,
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w800)),
                ),
                const SizedBox(width: 10),
                _RoleBadge(user.role),
              ]),
              const SizedBox(height: 12),
              _InfoLine(
                  icon: Icons.alternate_email,
                  label: 'Username',
                  value: user.username),
              _InfoLine(
                  icon: Icons.email_outlined,
                  label: 'Email',
                  value: user.email),
              _InfoLine(
                  icon: Icons.phone_outlined,
                  label: 'Phone',
                  value: user.phone),
              _InfoLine(
                  icon: Icons.business_outlined,
                  label: 'Company',
                  value: user.company),
              const SizedBox(height: 12),
              _userRoleControl(user),
              const Divider(height: 24),
              _userActions(user),
            ]),
          ),
      ],
    );
  }

  Widget _configurationStatusControl(AdminConfiguration item) =>
      _updatingConfigurations.contains(item.id)
          ? const SizedBox.square(
              dimension: 22, child: CircularProgressIndicator(strokeWidth: 2))
          : DropdownButtonFormField<String>(
              initialValue: statuses.contains(item.status) ? item.status : null,
              decoration:
                  _fieldDecoration('Change status', Icons.pending_actions),
              items: statuses
                  .map((value) => DropdownMenuItem(
                      value: value, child: Text(_titleCase(value))))
                  .toList(),
              onChanged: (value) => _changeStatus(item, value),
            );

  Widget _userRoleControl(AdminUser user) =>
      _updatingUsers.contains(user.userID)
          ? const SizedBox.square(
              dimension: 22, child: CircularProgressIndicator(strokeWidth: 2))
          : DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: roles.contains(user.role) ? user.role : null,
                hint: Text(user.role),
                items: roles
                    .map((value) => DropdownMenuItem(
                        value: value, child: Text(_titleCase(value))))
                    .toList(),
                onChanged: (value) => _changeRole(user, value),
              ),
            );

  Widget _userActions(AdminUser user) => _deletingUsers.contains(user.userID)
      ? const SizedBox.square(
          dimension: 22, child: CircularProgressIndicator(strokeWidth: 2))
      : Wrap(spacing: 4, runSpacing: 4, children: [
          IconButton(
            tooltip: 'View user',
            onPressed: () => _viewUser(user),
            icon: const Icon(Icons.visibility_outlined),
          ),
          IconButton(
            tooltip: 'Edit user',
            onPressed: () => _editUser(user),
            icon: const Icon(Icons.edit_outlined, color: Color(0xFF2563EB)),
          ),
          IconButton(
            tooltip: 'Delete user',
            onPressed: () => _deleteUser(user),
            icon: const Icon(Icons.delete_outline, color: Colors.red),
          ),
        ]);

  Widget _emptyCard(String text) => _AdminListCard(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 28),
          child: Center(child: Text(text)),
        ),
      );

  Widget _heading(String title, Future<void> Function() refresh) => Row(
        children: [
          Expanded(
              child: Text(title,
                  style: const TextStyle(
                      fontSize: 26, fontWeight: FontWeight.w800, color: navy))),
          IconButton.filledTonal(
              tooltip: 'Refresh',
              onPressed: refresh,
              icon: const Icon(Icons.refresh)),
        ],
      );

  Widget _tableContainer(
          {required bool empty,
          required String emptyText,
          required DataTable table}) =>
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: empty
            ? Padding(
                padding: const EdgeInsets.all(48),
                child: Center(child: Text(emptyText)))
            : LayoutBuilder(
                builder: (context, constraints) => SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minWidth: constraints.maxWidth),
                    child: table,
                  ),
                ),
              ),
      );

  Widget _summaryCards() => LayoutBuilder(builder: (context, constraints) {
        const gap = 14.0;
        final columns = constraints.maxWidth >= 1000
            ? 4
            : constraints.maxWidth >= 520
                ? 2
                : 1;
        final width = (constraints.maxWidth - gap * (columns - 1)) / columns;
        return Wrap(spacing: gap, runSpacing: gap, children: [
          _SummaryCard('Total', _summary.total, Icons.inventory_2_outlined,
              const Color(0xFF579AF6),
              width: width),
          _SummaryCard('Requested', _summary.requested, Icons.inbox_outlined,
              Colors.blue,
              width: width),
          _SummaryCard(
              'Pending', _summary.pending, Icons.pending_actions, Colors.orange,
              width: width),
          _SummaryCard('Done', _summary.done, Icons.task_alt, Colors.green,
              width: width),
        ]);
      });

  EdgeInsets _pagePadding() =>
      EdgeInsets.all(MediaQuery.sizeOf(context).width < 700 ? 12 : 24);

  double _columnSpacing() => MediaQuery.sizeOf(context).width >= 1200 ? 24 : 12;

  bool _isCompactLayout() => MediaQuery.sizeOf(context).width < 760;

  Widget _responsiveText(
      String value, double fraction, double minimum, double maximum) {
    final width =
        (MediaQuery.sizeOf(context).width * fraction).clamp(minimum, maximum);
    return SizedBox(
      width: width,
      child: Tooltip(
        message: value,
        child: Text(value, maxLines: 1, overflow: TextOverflow.ellipsis),
      ),
    );
  }

  String _date(DateTime? value) =>
      value == null ? '—' : DateFormat.yMMMd().add_jm().format(value.toLocal());
}

class _ConfigurationDetails extends StatelessWidget {
  const _ConfigurationDetails({required this.configuration});
  final AdminConfiguration configuration;

  @override
  Widget build(BuildContext context) => _AdminDetailsDialog(
        icon: Icons.tune,
        title: configuration.name,
        subtitle:
            '${configuration.cart.length} product${configuration.cart.length == 1 ? '' : 's'} configured',
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _PlainSectionBox(
            title: 'Configuration summary',
            children: [
              _plainInfoGrid([
                _PlainInfo('Status', _titleCase(configuration.status)),
                _PlainInfo('Products', '${configuration.cart.length}'),
                _PlainInfo(
                    'Date ordered', _friendlyDate(configuration.dateOrdered)),
                _PlainInfo('Completion date',
                    _friendlyDate(configuration.completeDate)),
              ]),
            ],
          ),
          const SizedBox(height: 16),
          if (configuration.cart.isEmpty)
            const _EmptyProductEditor()
          else
            _PlainSectionBox(
              title: 'Configured products',
              children: [
                LayoutBuilder(builder: (context, constraints) {
                  final width = _compactItemBoxWidth(constraints.maxWidth);
                  return Wrap(spacing: 12, runSpacing: 12, children: [
                    for (var index = 0;
                        index < configuration.cart.length;
                        index++)
                      _productDetails(
                          context, index, configuration.cart[index], width),
                  ]);
                }),
              ],
            ),
        ]),
      );

  Widget _productDetails(BuildContext context, int index,
      Map<String, dynamic> product, double width) {
    final rawInfo = product['productConfigurationInfo'];
    final info = rawInfo is Map ? rawInfo : const <String, dynamic>{};
    final simpleEntries = info.entries
        .where((entry) => entry.key != '_id' && !_isNested(entry.value));
    final nestedEntries = info.entries.where((entry) => _isNested(entry.value));
    return Container(
      width: width,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFCFF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          product['productType']?.toString() ?? 'Product ${index + 1}',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 10),
        _plainInfoGrid([
          _PlainInfo('Order ID', product['orderID']),
          _PlainInfo('Quantity requested', product['numRequested']),
          _PlainInfo('Created', _friendlyDate(product['orderCreated'])),
        ]),
        if (simpleEntries.isNotEmpty) ...[
          const SizedBox(height: 14),
          _PlainSubsection(
            title: 'Product configuration',
            child: _plainInfoGrid([
              for (final entry in simpleEntries)
                _PlainInfo(_readableLabel(entry.key.toString()), entry.value),
            ]),
          ),
        ],
        if (nestedEntries.isNotEmpty) ...[
          const SizedBox(height: 14),
          _PlainSubsection(
            title: 'Linked information',
            child: Column(children: [
              for (final entry in nestedEntries)
                _plainLinkedInfo(entry.key.toString(), entry.value),
            ]),
          ),
        ],
      ]),
    );
  }
}

class _EditConfigurationDialog extends StatefulWidget {
  const _EditConfigurationDialog({required this.configuration});
  final AdminConfiguration configuration;

  @override
  State<_EditConfigurationDialog> createState() =>
      _EditConfigurationDialogState();
}

class _EditConfigurationDialogState extends State<_EditConfigurationDialog> {
  late final TextEditingController _name;
  late final List<Map<String, dynamic>> _products;
  final Map<String, TextEditingController> _controllers = {};
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _name = TextEditingController(text: widget.configuration.name);
    _products = widget.configuration.cart
        .map((item) => Map<String, dynamic>.from(item))
        .toList();
    for (var index = 0; index < _products.length; index++) {
      final product = _products[index];
      _controllers['$index:numRequested'] =
          TextEditingController(text: '${product['numRequested'] ?? 0}');
      final rawInfo = product['productConfigurationInfo'];
      if (rawInfo is Map) {
        final info = Map<String, dynamic>.from(rawInfo);
        product['productConfigurationInfo'] = info;
        for (final entry in info.entries) {
          if (!_isNested(entry.value) && entry.key != '_id') {
            _controllers['$index:${entry.key}'] =
                TextEditingController(text: entry.value?.toString() ?? '');
          }
        }
      }
    }
  }

  @override
  void dispose() {
    _name.dispose();
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    for (var index = 0; index < _products.length; index++) {
      final product = _products[index];
      final quantity = _controllers['$index:numRequested']!.text;
      product['numRequested'] = int.parse(quantity);
      final info = product['productConfigurationInfo'];
      if (info is Map<String, dynamic>) {
        for (final entry in info.entries.toList()) {
          final controller = _controllers['$index:${entry.key}'];
          if (controller != null) {
            info[entry.key] = _restoreFieldType(controller.text, entry.value);
          }
        }
      }
    }
    Navigator.pop(context, {
      'configurationName': _name.text.trim(),
      'cart': _products,
    });
  }

  @override
  Widget build(BuildContext context) => _AdminEditDialog(
        icon: Icons.tune,
        title: 'Edit configuration',
        subtitle: 'Update the name or configured product information.',
        onSave: _save,
        child: Form(
          key: _formKey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            TextFormField(
              controller: _name,
              decoration: const InputDecoration(
                labelText: 'Configuration name',
                prefixIcon: Icon(Icons.label_outline),
                border: OutlineInputBorder(),
              ),
              validator: (value) => value == null || value.trim().isEmpty
                  ? 'Configuration name is required.'
                  : null,
            ),
            const SizedBox(height: 20),
            Row(children: [
              const Expanded(
                child: Text('Configured products',
                    style:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
              ),
              _Badge(
                  label:
                      '${_products.length} product${_products.length == 1 ? '' : 's'}',
                  color: Colors.blue),
            ]),
            const SizedBox(height: 12),
            if (_products.isEmpty)
              const _EmptyProductEditor()
            else
              for (var index = 0; index < _products.length; index++)
                _productEditor(index, _products[index]),
          ]),
        ),
      );

  Widget _productEditor(int index, Map<String, dynamic> product) {
    final rawInfo = product['productConfigurationInfo'];
    final info =
        rawInfo is Map<String, dynamic> ? rawInfo : const <String, dynamic>{};
    final editableEntries = info.entries
        .where((entry) => entry.key != '_id' && !_isNested(entry.value));
    final nestedEntries = info.entries.where((entry) => _isNested(entry.value));
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Color(0xFFDCE4F0)),
        borderRadius: BorderRadius.circular(14),
      ),
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        initiallyExpanded: index == 0,
        backgroundColor: Colors.white,
        collapsedBackgroundColor: const Color(0xFFFAFCFF),
        leading: Container(
          width: 42,
          height: 42,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xFFE8F1FF),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(Icons.precision_manufacturing_outlined,
              color: Color(0xFF2563EB)),
        ),
        title: Text(
            product['productType']?.toString() ?? 'Product ${index + 1}',
            style: const TextStyle(fontWeight: FontWeight.w800)),
        subtitle: Text('Order ${product['orderID'] ?? '—'}'),
        children: [
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(18),
            child: LayoutBuilder(builder: (context, constraints) {
              final width = _compactFieldWidth(constraints.maxWidth);
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(spacing: 14, runSpacing: 14, children: [
                      _readOnlyField(
                          'Product type', product['productType'], width),
                      _readOnlyField('Order ID', product['orderID'], width),
                      SizedBox(
                        width: width,
                        child: TextFormField(
                          controller: _controllers['$index:numRequested'],
                          keyboardType: TextInputType.number,
                          decoration: _fieldDecoration(
                              'Quantity requested', Icons.numbers_outlined),
                          validator: (value) {
                            final parsed = int.tryParse(value ?? '');
                            return parsed == null || parsed < 1
                                ? 'Enter a quantity of 1 or more.'
                                : null;
                          },
                        ),
                      ),
                      _readOnlyField('Created',
                          _friendlyDate(product['orderCreated']), width),
                    ]),
                    if (editableEntries.isNotEmpty) ...[
                      const SizedBox(height: 22),
                      const _EditorSectionTitle(
                          icon: Icons.settings_outlined,
                          title: 'Product configuration'),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 14,
                        runSpacing: 14,
                        children: [
                          for (final entry in editableEntries)
                            SizedBox(
                              width: width,
                              child: TextFormField(
                                controller: _controllers['$index:${entry.key}'],
                                keyboardType: entry.value is num
                                    ? const TextInputType.numberWithOptions(
                                        decimal: true)
                                    : TextInputType.text,
                                maxLines:
                                    entry.key.toLowerCase().contains('note')
                                        ? 3
                                        : 1,
                                decoration: _fieldDecoration(
                                    _readableLabel(entry.key),
                                    _fieldIcon(entry.key)),
                              ),
                            ),
                        ],
                      ),
                    ],
                    if (nestedEntries.isNotEmpty) ...[
                      const SizedBox(height: 22),
                      const _EditorSectionTitle(
                          icon: Icons.account_tree_outlined,
                          title: 'Linked information'),
                      const SizedBox(height: 10),
                      for (final entry in nestedEntries)
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8FAFC),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(_readableLabel(entry.key),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700)),
                              const SizedBox(height: 5),
                              Text(_nestedSummary(entry.value),
                                  style: const TextStyle(
                                      color: Color(0xFF64748B))),
                            ],
                          ),
                        ),
                    ],
                  ]);
            }),
          ),
        ],
      ),
    );
  }

  Widget _readOnlyField(String label, dynamic value, double width) => SizedBox(
        width: width,
        child: InputDecorator(
          decoration: _fieldDecoration(label, Icons.lock_outline),
          child: Text(value?.toString() ?? '—', maxLines: 1),
        ),
      );
}

bool _isNested(dynamic value) => value is Map || value is List;

dynamic _restoreFieldType(String value, dynamic original) {
  if (original is int) return int.tryParse(value) ?? original;
  if (original is double) return double.tryParse(value) ?? original;
  if (original is bool) {
    return value.trim().toLowerCase() == 'true';
  }
  return value;
}

InputDecoration _fieldDecoration(String label, IconData icon) =>
    InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, size: 20),
      border: const OutlineInputBorder(),
      enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFD7E0EC))),
      filled: true,
      fillColor: Colors.white,
    );

String _readableLabel(String key) {
  const overrides = {
    'cc5ChainSize': 'CC5 chain size',
    'appEnviroment': 'Application environment',
    'numRequested': 'Quantity requested',
  };
  if (overrides.containsKey(key)) return overrides[key]!;
  final spaced = key
      .replaceAllMapped(
          RegExp(r'([a-z0-9])([A-Z])'), (match) => '${match[1]} ${match[2]}')
      .replaceAll('_', ' ')
      .trim();
  return spaced.isEmpty
      ? key
      : '${spaced[0].toUpperCase()}${spaced.substring(1)}';
}

IconData _fieldIcon(String key) {
  final lower = key.toLowerCase();
  if (lower.contains('name')) return Icons.label_outline;
  if (lower.contains('length') || lower.contains('measurement')) {
    return Icons.straighten;
  }
  if (lower.contains('speed')) return Icons.speed;
  if (lower.contains('temp') || lower.contains('environment')) {
    return Icons.thermostat_outlined;
  }
  if (lower.contains('voltage')) return Icons.bolt_outlined;
  if (lower.contains('note')) return Icons.notes_outlined;
  if (lower.contains('direction')) return Icons.swap_horiz;
  if (lower.contains('status')) return Icons.tune;
  return Icons.edit_outlined;
}

String _friendlyDate(dynamic raw) {
  final date = DateTime.tryParse(raw?.toString() ?? '');
  return date == null
      ? '—'
      : DateFormat.yMMMd().add_jm().format(date.toLocal());
}

String _nestedSummary(dynamic value) {
  if (value is Map) {
    return value.entries
        .map((entry) =>
            '${_readableLabel(entry.key.toString())}: ${entry.value}')
        .join(' · ');
  }
  if (value is List) return '${value.length} linked item(s)';
  return value?.toString() ?? '—';
}

Widget _detailField(String label, dynamic value, IconData icon, double width) =>
    SizedBox(
      width: width,
      child: InputDecorator(
        decoration: _fieldDecoration(label, icon),
        child: SelectableText(
          value?.toString().isEmpty ?? true ? '—' : value.toString(),
          maxLines: 3,
        ),
      ),
    );

class _PlainInfo {
  const _PlainInfo(this.label, this.value);
  final String label;
  final dynamic value;
}

class _PlainSectionBox extends StatelessWidget {
  const _PlainSectionBox({required this.title, required this.children});
  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFDCE4F0)),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
          const SizedBox(height: 14),
          ...children,
        ]),
      );
}

class _PlainSubsection extends StatelessWidget {
  const _PlainSubsection({required this.title, required this.child});
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 10),
          child,
        ]),
      );
}

Widget _plainInfoGrid(List<_PlainInfo> items) =>
    LayoutBuilder(builder: (context, constraints) {
      final width = _compactFieldWidth(constraints.maxWidth);
      return Wrap(
        spacing: 12,
        runSpacing: 12,
        children: [
          for (final item in items)
            SizedBox(
              width: width,
              child: _plainInfoRow(item.label, item.value),
            ),
        ],
      );
    });

Widget _plainInfoRow(String label, dynamic value) => Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label,
            style: const TextStyle(
                color: Color(0xFF64748B),
                fontSize: 12,
                fontWeight: FontWeight.w700)),
        const SizedBox(height: 4),
        SelectableText(
          value?.toString().isEmpty ?? true ? '—' : value.toString(),
          maxLines: 4,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ]),
    );

Widget _plainLinkedInfo(String label, dynamic value) => Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: _plainInfoRow(_readableLabel(label), _nestedSummary(value)),
    );

double _compactFieldWidth(double maxWidth) {
  if (maxWidth < 520) return maxWidth;
  return ((maxWidth - 24) / 3).clamp(190.0, 240.0);
}

double _compactItemBoxWidth(double maxWidth) {
  if (maxWidth < 560) return maxWidth;
  return ((maxWidth - 12) / 2).clamp(260.0, 340.0);
}

class _EditorSectionTitle extends StatelessWidget {
  const _EditorSectionTitle({required this.icon, required this.title});
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) => Row(children: [
        Icon(icon, size: 20, color: const Color(0xFF2563EB)),
        const SizedBox(width: 8),
        Text(title,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800)),
      ]);
}

class _EmptyProductEditor extends StatelessWidget {
  const _EmptyProductEditor();

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: const Column(children: [
          Icon(Icons.inventory_2_outlined, color: Colors.grey, size: 34),
          SizedBox(height: 8),
          Text('No configured products are available to edit.'),
        ]),
      );
}

class _EditUserDialog extends StatefulWidget {
  const _EditUserDialog({required this.user, required this.api});
  final AdminUser user;
  final AdminAPI api;

  @override
  State<_EditUserDialog> createState() => _EditUserDialogState();
}

class _EditUserDialogState extends State<_EditUserDialog> {
  final _formKey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();
  late final Map<String, TextEditingController> _fields;
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();
  bool _passwordHidden = true;
  bool _confirmPasswordHidden = true;
  bool _resettingPassword = false;
  String? _passwordMessage;
  bool _passwordError = false;

  @override
  void initState() {
    super.initState();
    _fields = {
      'firstName': TextEditingController(text: widget.user.firstName),
      'lastName': TextEditingController(text: widget.user.lastName),
      'username': TextEditingController(text: widget.user.username),
      'email': TextEditingController(text: widget.user.email),
      'phoneNumber': TextEditingController(text: widget.user.phone),
      'companyName': TextEditingController(text: widget.user.company),
      'country': TextEditingController(text: widget.user.country),
    };
  }

  @override
  void dispose() {
    for (final controller in _fields.values) {
      controller.dispose();
    }
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.pop(
        context, _fields.map((key, value) => MapEntry(key, value.text.trim())));
  }

  Future<void> _resetPassword() async {
    if (!_passwordFormKey.currentState!.validate()) return;
    setState(() {
      _resettingPassword = true;
      _passwordMessage = null;
      _passwordError = false;
    });
    try {
      await widget.api.resetUserPassword(widget.user.userID, _password.text);
      final prefs = await SharedPreferences.getInstance();
      final currentUsername = prefs.getString('username')?.toLowerCase();
      final isSelf = currentUsername != null &&
          currentUsername == widget.user.username.toLowerCase();
      if (!mounted) return;
      if (isSelf) {
        await prefs.remove('sessionID');
        await prefs.remove('role');
        await prefs.remove('username');
        if (mounted) {
          Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false);
        }
        return;
      }
      setState(() {
        _resettingPassword = false;
        _password.clear();
        _confirmPassword.clear();
        _passwordMessage =
            'Password reset successfully. Existing sessions were signed out.';
      });
    } on AdminApiException catch (error) {
      if (!mounted) return;
      if (error.unauthorized) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('sessionID');
        await prefs.remove('role');
        await prefs.remove('username');
        if (mounted) {
          Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false);
        }
        return;
      }
      setState(() {
        _resettingPassword = false;
        _passwordError = true;
        _passwordMessage =
            error.statusCode == 404 ? 'User not found.' : error.message;
      });
    } catch (_) {
      if (mounted) {
        setState(() {
          _resettingPassword = false;
          _passwordError = true;
          _passwordMessage = 'A server error occurred. Please try again.';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) => _AdminEditDialog(
        icon: Icons.manage_accounts_outlined,
        title: 'Edit user',
        subtitle: 'Manage profile information and account security.',
        onSave: _save,
        child: Form(
          key: _formKey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const _EditorSectionTitle(
                icon: Icons.badge_outlined, title: 'User information'),
            const SizedBox(height: 6),
            const Text(
                'Update this user’s personal, contact, and company details.',
                style: TextStyle(color: Color(0xFF64748B))),
            const SizedBox(height: 16),
            LayoutBuilder(builder: (context, constraints) {
              final fieldWidth = _compactFieldWidth(constraints.maxWidth);
              return Wrap(spacing: 16, runSpacing: 16, children: [
                _userField(
                    'firstName', 'First name', Icons.person_outline, fieldWidth,
                    required: true),
                _userField(
                    'lastName', 'Last name', Icons.person_outline, fieldWidth,
                    required: true),
                _userField(
                    'username', 'Username', Icons.alternate_email, fieldWidth,
                    required: true),
                _userField('email', 'Email', Icons.email_outlined, fieldWidth,
                    required: true),
                _userField(
                    'phoneNumber', 'Phone', Icons.phone_outlined, fieldWidth),
                _userField('companyName', 'Company', Icons.business_outlined,
                    fieldWidth),
                _userField('country', 'Country', Icons.public, fieldWidth),
              ]);
            }),
            const SizedBox(height: 28),
            const Divider(),
            const SizedBox(height: 18),
            _passwordSection(),
          ]),
        ),
      );

  Widget _passwordSection() => Form(
        key: _passwordFormKey,
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFBEB),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFFDE68A)),
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const _EditorSectionTitle(
                icon: Icons.password_outlined, title: 'Reset password'),
            const SizedBox(height: 6),
            const Text(
              'No old password or security PIN is required. All existing sessions for this user will be signed out.',
              style: TextStyle(color: Color(0xFF78716C)),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _password,
              obscureText: _passwordHidden,
              decoration: InputDecoration(
                labelText: 'New password',
                prefixIcon: const Icon(Icons.lock_outline),
                border: const OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
                suffixIcon: IconButton(
                  onPressed: () =>
                      setState(() => _passwordHidden = !_passwordHidden),
                  icon: Icon(_passwordHidden
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined),
                ),
              ),
              validator: (value) => value == null || value.length < 8
                  ? 'Password must contain at least 8 characters.'
                  : null,
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _confirmPassword,
              obscureText: _confirmPasswordHidden,
              decoration: InputDecoration(
                labelText: 'Confirm new password',
                prefixIcon: const Icon(Icons.lock_reset_outlined),
                border: const OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
                suffixIcon: IconButton(
                  onPressed: () => setState(
                      () => _confirmPasswordHidden = !_confirmPasswordHidden),
                  icon: Icon(_confirmPasswordHidden
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined),
                ),
              ),
              validator: (value) =>
                  value != _password.text ? 'Passwords do not match.' : null,
            ),
            if (_passwordMessage != null) ...[
              const SizedBox(height: 12),
              Row(children: [
                Icon(_passwordError ? Icons.error_outline : Icons.check_circle,
                    size: 20,
                    color: _passwordError ? Colors.red : Colors.green),
                const SizedBox(width: 8),
                Expanded(
                    child: Text(_passwordMessage!,
                        style: TextStyle(
                            color: _passwordError
                                ? Colors.red.shade700
                                : Colors.green.shade700))),
              ]),
            ],
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: FilledButton.icon(
                style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFFB45309)),
                onPressed: _resettingPassword ? null : _resetPassword,
                icon: _resettingPassword
                    ? const SizedBox.square(
                        dimension: 16,
                        child: CircularProgressIndicator(strokeWidth: 2))
                    : const Icon(Icons.lock_reset),
                label: Text(_resettingPassword
                    ? 'Resetting password…'
                    : 'Update password'),
              ),
            ),
          ]),
        ),
      );

  Widget _userField(String key, String label, IconData icon, double width,
          {bool required = false}) =>
      SizedBox(
        width: width,
        child: TextFormField(
          controller: _fields[key],
          decoration: InputDecoration(
            labelText: label,
            prefixIcon: Icon(icon),
            border: const OutlineInputBorder(),
          ),
          validator: required
              ? (value) => value == null || value.trim().isEmpty
                  ? '$label is required.'
                  : null
              : null,
        ),
      );
}

class _UserDetails extends StatelessWidget {
  const _UserDetails({required this.user});
  final AdminUser user;

  @override
  Widget build(BuildContext context) => _AdminDetailsDialog(
        icon: Icons.manage_accounts_outlined,
        title: user.name,
        subtitle: 'User information and account role.',
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const _EditorSectionTitle(
              icon: Icons.badge_outlined, title: 'User information'),
          const SizedBox(height: 16),
          LayoutBuilder(builder: (context, constraints) {
            final width = _compactFieldWidth(constraints.maxWidth);
            return Wrap(spacing: 14, runSpacing: 14, children: [
              _detailField(
                  'First name', user.firstName, Icons.person_outline, width),
              _detailField(
                  'Last name', user.lastName, Icons.person_outline, width),
              _detailField(
                  'Username', user.username, Icons.alternate_email, width),
              _detailField('Email', user.email, Icons.email_outlined, width),
              _detailField('Phone', user.phone, Icons.phone_outlined, width),
              _detailField(
                  'Company', user.company, Icons.business_outlined, width),
              _detailField('Country', user.country, Icons.public, width),
              _detailField('Role', _titleCase(user.role),
                  Icons.admin_panel_settings_outlined, width),
            ]);
          }),
        ]),
      );
}

class _AdminDetailsDialog extends StatelessWidget {
  const _AdminDetailsDialog({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.child,
  });
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.sizeOf(context);
    final compact = screen.width < 560;
    return Dialog(
      insetPadding: EdgeInsets.all(compact ? 8 : 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 780,
          maxHeight: screen.height - (compact ? 24 : 48),
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
            padding: EdgeInsets.fromLTRB(
                compact ? 16 : 24, compact ? 16 : 20, 8, compact ? 14 : 18),
            decoration: const BoxDecoration(
              color: Color(0xFFF1F5FF),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Row(children: [
              if (!compact) ...[
                CircleAvatar(
                  backgroundColor: const Color(0xFF2563EB),
                  foregroundColor: Colors.white,
                  child: Icon(icon),
                ),
                const SizedBox(width: 14),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: compact ? 18 : 21,
                            fontWeight: FontWeight.w800)),
                    const SizedBox(height: 3),
                    Text(subtitle,
                        style: const TextStyle(color: Color(0xFF64748B))),
                  ],
                ),
              ),
              IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close)),
            ]),
          ),
          Flexible(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(compact ? 14 : 24),
              child: child,
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: EdgeInsets.all(compact ? 12 : 16),
            child: Align(
              alignment: Alignment.centerRight,
              child: FilledButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.check),
                label: const Text('Done'),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class _AdminEditDialog extends StatelessWidget {
  const _AdminEditDialog({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onSave,
    required this.child,
  });
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onSave;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.sizeOf(context);
    final compact = screen.width < 560;
    return Dialog(
      insetPadding: EdgeInsets.all(compact ? 8 : 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ConstrainedBox(
        constraints: BoxConstraints(
            maxWidth: 780, maxHeight: screen.height - (compact ? 24 : 48)),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
            padding: EdgeInsets.fromLTRB(
                compact ? 16 : 24, compact ? 16 : 20, 8, compact ? 14 : 18),
            decoration: const BoxDecoration(
              color: Color(0xFFF1F5FF),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Row(children: [
              if (!compact) ...[
                CircleAvatar(
                  backgroundColor: const Color(0xFF2563EB),
                  foregroundColor: Colors.white,
                  child: Icon(icon),
                ),
                const SizedBox(width: 14),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: compact ? 18 : 21,
                            fontWeight: FontWeight.w800)),
                    const SizedBox(height: 3),
                    Text(subtitle,
                        style: const TextStyle(color: Color(0xFF64748B))),
                  ],
                ),
              ),
              IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close)),
            ]),
          ),
          Flexible(
              child: SingleChildScrollView(
                  padding: EdgeInsets.all(compact ? 14 : 24), child: child)),
          const Divider(height: 1),
          Padding(
            padding: EdgeInsets.all(compact ? 12 : 16),
            child: Wrap(
                alignment: WrapAlignment.end,
                spacing: 10,
                runSpacing: 8,
                children: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel')),
                  FilledButton.icon(
                    onPressed: onSave,
                    icon: const Icon(Icons.save_outlined),
                    label: const Text('Save changes'),
                  ),
                ]),
          ),
        ]),
      ),
    );
  }
}

class _AdminListCard extends StatelessWidget {
  const _AdminListCard({required this.child, this.margin = EdgeInsets.zero});
  final Widget child;
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        margin: margin,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: child,
      );
}

class _InfoLine extends StatelessWidget {
  const _InfoLine({
    required this.icon,
    required this.label,
    required this.value,
  });
  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Icon(icon, size: 18, color: const Color(0xFF64748B)),
          const SizedBox(width: 8),
          SizedBox(
            width: 78,
            child: Text(label,
                style: const TextStyle(
                    color: Color(0xFF64748B), fontWeight: FontWeight.w600)),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(value.isEmpty ? '—' : value,
                overflow: TextOverflow.visible),
          ),
        ]),
      );
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard(this.label, this.total, this.icon, this.color,
      {required this.width});
  final String label;
  final int total;
  final IconData icon;
  final Color color;
  final double width;

  @override
  Widget build(BuildContext context) => Container(
        width: width,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Row(children: [
          CircleAvatar(
              backgroundColor: color.withValues(alpha: .12),
              child: Icon(icon, color: color)),
          const SizedBox(width: 14),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('$total',
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.w800)),
            Text(label, style: const TextStyle(color: Colors.grey)),
          ]),
        ]),
      );
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge(this.status);
  final String status;

  @override
  Widget build(BuildContext context) {
    final color = switch (status) {
      'done' => Colors.green,
      'pending' => Colors.orange,
      _ => Colors.blue,
    };
    return _Badge(label: _titleCase(status), color: color);
  }
}

class _RoleBadge extends StatelessWidget {
  const _RoleBadge(this.role);
  final String role;

  @override
  Widget build(BuildContext context) => _Badge(
      label: _titleCase(role),
      color: role == 'admin' ? Colors.deepPurple : Colors.blueGrey);
}

class _Badge extends StatelessWidget {
  const _Badge({required this.label, required this.color});
  final String label;
  final MaterialColor color;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: color.withValues(alpha: .12),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(label,
            style:
                TextStyle(color: color.shade700, fontWeight: FontWeight.w700)),
      );
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});
  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) => Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Icon(Icons.error_outline, size: 48, color: Colors.red),
          const SizedBox(height: 12),
          Text(message),
          const SizedBox(height: 16),
          FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Try again')),
        ]),
      );
}

String _titleCase(String value) => value.isEmpty
    ? value
    : '${value[0].toUpperCase()}${value.substring(1).toLowerCase()}';
