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
  AdminListFilters _configurationFilters =
      const AdminListFilters(status: 'all');
  AdminListFilters _userFilters = const AdminListFilters();
  bool _groupConfigurationsByStatus = false;

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
      final result = await _api.getConfigurations(
        filters: _configurationFilters,
      );
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
      final users = await _api.getUsers(
        filters: _userFilters,
      );
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

  void _setConfigurationFilters(AdminListFilters filters) {
    setState(() => _configurationFilters = filters);
    _loadConfigurations();
  }

  void _setGroupConfigurationsByStatus(bool value) {
    setState(() => _groupConfigurationsByStatus = value);
  }

  void _setUserFilters(AdminListFilters filters) {
    setState(() => _userFilters = filters);
    _loadUsers();
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
      child: Builder(builder: (context) {
        return Scaffold(
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
                tooltip: 'Refresh',
                onPressed: () {
                  final index = DefaultTabController.of(context).index;
                  if (index == 0) {
                    _loadConfigurations();
                  } else {
                    _loadUsers();
                  }
                },
                icon: const Icon(Icons.refresh),
              ),
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
        );
      }),
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
        _AdminListFilterBar(
          filters: _configurationFilters,
          onChanged: _setConfigurationFilters,
          showStatusFilter: true,
          groupByStatus: _groupConfigurationsByStatus,
          onGroupByStatusChanged: _setGroupConfigurationsByStatus,
        ),
        const SizedBox(height: 18),
        _summaryCards(),
        const SizedBox(height: 22),
        _configurationList(compact),
      ]),
    );
  }

  Widget _configurationList(bool compact) {
    if (!_groupConfigurationsByStatus) {
      return compact
          ? _configurationCards()
          : _configurationTable(_configurations);
    }

    final sections = [
      for (final status in statuses)
        MapEntry(
          status,
          _configurations.where((item) => item.status == status).toList(),
        ),
    ].where((entry) => entry.value.isNotEmpty).toList();

    if (sections.isEmpty) {
      return _emptyCard('No configurations found.');
    }

    return Column(children: [
      for (final section in sections) ...[
        _StatusSectionHeader(
          status: section.key,
          count: section.value.length,
        ),
        const SizedBox(height: 10),
        compact
            ? _configurationCards(items: section.value)
            : _configurationTable(section.value),
        const SizedBox(height: 18),
      ],
    ]);
  }

  Widget _configurationTable(List<AdminConfiguration> items) => _tableContainer(
        empty: items.isEmpty,
        emptyText: 'No configurations found.',
        table: DataTable(
          columnSpacing: _columnSpacing(),
          horizontalMargin: 12,
          headingRowHeight: 44,
          dataRowMinHeight: 66,
          dataRowMaxHeight: 76,
          dividerThickness: .65,
          columns: const [
            DataColumn(label: Text('Configuration name')),
            DataColumn(label: Text('Status')),
            DataColumn(label: Text('Created')),
            DataColumn(label: Text('Updated')),
            DataColumn(label: Text('Date ordered')),
            DataColumn(label: Text('Completion date')),
            DataColumn(label: Text('Products'), numeric: true),
            DataColumn(label: Text('Details')),
            DataColumn(label: Text('Change status')),
            DataColumn(label: Text('Actions')),
          ],
          rows: items.map(_configurationRow).toList(),
        ),
      );

  DataRow _configurationRow(AdminConfiguration item) => DataRow(cells: [
        DataCell(_responsiveText(item.name, .15, 130, 240)),
        DataCell(Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _StatusBadge(item.status),
            if (item.status == 'pending') ...[
              const SizedBox(height: 4),
              _PendingAgePill(configuration: item),
            ],
          ],
        )),
        DataCell(_dateAgeCell(item.createdAt, .12, 125, 190)),
        DataCell(_hasDistinctUpdate(item)
            ? _dateAgeCell(item.updatedAt, .12, 125, 190)
            : const Text('—')),
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
        _AdminListFilterBar(
          filters: _userFilters,
          onChanged: _setUserFilters,
        ),
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
            DataColumn(label: Text('Created')),
            DataColumn(label: Text('Updated')),
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
                    DataCell(
                        _responsiveText(_date(user.createdAt), .12, 125, 190)),
                    DataCell(
                        _responsiveText(_date(user.updatedAt), .12, 125, 190)),
                    DataCell(_RoleBadge(user.role)),
                    DataCell(_userRoleControl(user)),
                    DataCell(_userActions(user)),
                  ]))
              .toList(),
        ),
      );

  Widget _configurationCards({List<AdminConfiguration>? items}) {
    final data = items ?? _configurations;
    if (data.isEmpty) {
      return _emptyCard('No configurations found.');
    }
    return Column(
      children: [
        for (final item in data)
          _AdminListCard(
            margin: const EdgeInsets.only(bottom: 12),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                _CreatedAgeChip(configuration: item),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    item.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.w800),
                  ),
                ),
                const SizedBox(width: 8),
                _StatusBadge(item.status, compact: true),
                const SizedBox(width: 4),
                _ConfigurationCardActions(
                  isDeleting: _deletingConfigurations.contains(item.id),
                  onView: () => showDialog<void>(
                      context: context,
                      builder: (_) =>
                          _ConfigurationDetails(configuration: item)),
                  onEdit: () => _editConfiguration(item),
                  onDelete: () => _deleteConfiguration(item),
                ),
              ]),
              if (item.status == 'pending') ...[
                const SizedBox(height: 12),
                _PendingAgePanel(configuration: item),
              ],
              const SizedBox(height: 12),
              _configurationInfoGrid(item),
              const SizedBox(height: 12),
              _configurationStatusControl(item),
            ]),
          ),
      ],
    );
  }

  Widget _configurationInfoGrid(AdminConfiguration item) =>
      LayoutBuilder(builder: (context, constraints) {
        const gap = 10.0;
        final width = (constraints.maxWidth - gap) / 2;
        final info = [
          _InfoTileData(
              Icons.add_circle_outline, 'Created', _date(item.createdAt)),
          _InfoTileData(
              Icons.inventory_2_outlined, 'Products', '${item.cart.length}'),
          _InfoTileData(Icons.tune_outlined, 'Configuration',
              _configurationProductSummary(item)),
          _InfoTileData(Icons.settings_suggest_outlined, 'Product config',
              _productConfigurationPreview(item)),
        ];
        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: [
            for (final item in info)
              SizedBox(width: width, child: _InfoTile(item: item)),
          ],
        );
      });

  String _configurationProductSummary(AdminConfiguration item) {
    if (item.cart.isEmpty) return 'No products';

    final productTypes = item.cart
        .map((product) => product['productType']?.toString().trim() ?? '')
        .where((value) => value.isNotEmpty)
        .toList();
    if (productTypes.isNotEmpty) {
      final shown = productTypes.take(2).join(', ');
      final hidden = productTypes.length - 2;
      return hidden > 0 ? '$shown +$hidden' : shown;
    }

    final configuredCount = item.cart.where((product) {
      final info = product['productConfigurationInfo'];
      return info is Map && info.isNotEmpty;
    }).length;
    if (configuredCount > 0) {
      return '$configuredCount configured';
    }
    return '${item.cart.length} configured';
  }

  String _productConfigurationPreview(AdminConfiguration item) {
    final previews = <String>[];
    for (final product in item.cart) {
      final rawInfo = product['productConfigurationInfo'];
      if (rawInfo is! Map) continue;

      for (final entry in rawInfo.entries) {
        final key = entry.key.toString();
        if (key == '_id' || _isNested(entry.value)) continue;

        final value = entry.value?.toString().trim() ?? '';
        if (value.isEmpty) continue;
        previews.add('$key: $value');
        break;
      }
      if (previews.length == 2) break;
    }

    if (previews.isNotEmpty) return previews.join(', ');

    final configuredCount = item.cart.where((product) {
      final info = product['productConfigurationInfo'];
      return info is Map && info.isNotEmpty;
    }).length;
    return configuredCount > 0 ? '$configuredCount configured' : 'No details';
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
              _InfoLine(
                  icon: Icons.add_circle_outline,
                  label: 'Created',
                  value: _date(user.createdAt)),
              _InfoLine(
                  icon: Icons.update,
                  label: 'Updated',
                  value: _date(user.updatedAt)),
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
        const gap = 10.0;
        final width = constraints.maxWidth >= 760
            ? (constraints.maxWidth - gap * 3) / 4
            : 112.0;
        final showIcons = constraints.maxWidth >= 760;
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: [
            _SummaryCard('Total', _summary.total, Icons.inventory_2_outlined,
                const Color(0xFF579AF6),
                width: width, showIcon: showIcons),
            const SizedBox(width: gap),
            _SummaryCard('Requested', _summary.requested, Icons.inbox_outlined,
                Colors.blue,
                width: width, showIcon: showIcons),
            const SizedBox(width: gap),
            _SummaryCard('Pending', _summary.pending, Icons.pending_actions,
                Colors.orange,
                width: width, showIcon: showIcons),
            const SizedBox(width: gap),
            _SummaryCard('Done', _summary.done, Icons.task_alt, Colors.green,
                width: width, showIcon: showIcons),
          ]),
        );
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

  Widget _dateAgeCell(
      DateTime? value, double fraction, double minimum, double maximum) {
    final width =
        (MediaQuery.sizeOf(context).width * fraction).clamp(minimum, maximum);
    final date = _date(value);
    final age = _elapsedAge(value)?.value;
    return SizedBox(
      width: width,
      child: Tooltip(
        message: age == null ? date : '$date · $age ago',
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(date, maxLines: 1, overflow: TextOverflow.ellipsis),
            if (age != null) ...[
              const SizedBox(height: 2),
              Text(
                '$age ago',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF17223B),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _AdminListFilterBar extends StatelessWidget {
  const _AdminListFilterBar({
    required this.filters,
    required this.onChanged,
    this.showStatusFilter = false,
    this.groupByStatus = false,
    this.onGroupByStatusChanged,
  });

  static const _dateFields = {
    'createdAt': 'Created date',
    'updatedAt': 'Updated date',
  };
  static const _dateFilters = {
    'all': 'All dates',
    'today': 'Today',
    'lastDay': 'Yesterday',
    'thisWeek': 'This week',
    'custom': 'Custom range',
  };
  static const _statusFilters = {
    'all': 'All statuses',
    'requested': 'Requested',
    'pending': 'Pending',
    'done': 'Done',
  };

  final AdminListFilters filters;
  final ValueChanged<AdminListFilters> onChanged;
  final bool showStatusFilter;
  final bool groupByStatus;
  final ValueChanged<bool>? onGroupByStatusChanged;

  @override
  Widget build(BuildContext context) {
    final custom = filters.dateFilter == 'custom';
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: LayoutBuilder(builder: (context, constraints) {
        final compact = constraints.maxWidth < 720;
        final halfWidth = (constraints.maxWidth - 8) / 2;
        final controls = showStatusFilter ? 5 : 3;
        final desktopGap = 12.0 * (controls - 1);
        final remaining = constraints.maxWidth - desktopGap - 44;
        final sortWidth =
            compact ? halfWidth : (remaining * .26).clamp(200.0, 280.0);
        final dateWidth =
            compact ? halfWidth : (remaining * .29).clamp(220.0, 320.0);
        final statusWidth =
            compact ? halfWidth : (remaining * .20).clamp(170.0, 230.0);
        final groupWidth = compact
            ? (constraints.maxWidth - sortWidth - 44 - 16).clamp(104.0, 180.0)
            : (constraints.maxWidth -
                    desktopGap -
                    44 -
                    sortWidth -
                    dateWidth -
                    statusWidth)
                .clamp(190.0, 280.0);
        final customDateWidth = compact
            ? halfWidth
            : (constraints.maxWidth - dateWidth - 24).clamp(180.0, 220.0);
        return Wrap(
          spacing: compact ? 8 : 12,
          runSpacing: compact ? 8 : 10,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            _dropdown(
              width: sortWidth,
              label: compact ? 'Sort' : 'Sort by',
              icon: compact ? null : Icons.sort,
              value: filters.sortBy,
              options: _dateFields,
              onChanged: (value) => onChanged(filters.copyWith(
                sortBy: value,
                dateField: value,
              )),
            ),
            _SortDirectionButton(
              compact: compact,
              sortOrder: filters.sortOrder,
              onPressed: () => onChanged(filters.copyWith(
                sortOrder: filters.sortOrder == 'asc' ? 'desc' : 'asc',
              )),
            ),
            if (showStatusFilter && compact)
              _GroupByStatusCheckbox(
                width: groupWidth,
                selected: groupByStatus,
                compact: compact,
                onChanged: onGroupByStatusChanged,
              ),
            _dropdown(
              width: dateWidth,
              label: compact ? 'Date' : 'Filter dates',
              icon: compact ? null : Icons.filter_alt_outlined,
              value: filters.dateFilter,
              options: _dateFilters,
              onChanged: (value) {
                if (value == 'custom') {
                  final today = DateTime.now();
                  onChanged(filters.copyWith(
                    dateField: filters.sortBy,
                    dateFilter: value,
                    startDate: filters.startDate ?? today,
                    endDate: filters.endDate ?? today,
                  ));
                  return;
                }
                onChanged(filters.copyWith(
                  dateField: filters.sortBy,
                  dateFilter: value,
                  clearDates: true,
                ));
              },
            ),
            if (showStatusFilter) ...[
              _dropdown(
                width: statusWidth,
                label: 'Status',
                icon: compact ? null : Icons.flag_outlined,
                value: filters.status ?? 'all',
                options: _statusFilters,
                onChanged: (value) => onChanged(filters.copyWith(
                  status: value,
                )),
              ),
              if (!compact)
                _GroupByStatusCheckbox(
                  width: groupWidth,
                  selected: groupByStatus,
                  compact: compact,
                  onChanged: onGroupByStatusChanged,
                ),
            ],
            if (custom) ...[
              _dateButton(
                context: context,
                width: customDateWidth,
                label: 'Start',
                icon: Icons.date_range_outlined,
                value: filters.startDate,
                onPicked: (date) => onChanged(filters.copyWith(
                  startDate: date,
                  endDate:
                      filters.endDate != null && filters.endDate!.isBefore(date)
                          ? date
                          : filters.endDate,
                )),
              ),
              _dateButton(
                context: context,
                width: customDateWidth,
                label: 'End',
                icon: Icons.event_available_outlined,
                value: filters.endDate,
                firstDate: filters.startDate,
                onPicked: (date) => onChanged(filters.copyWith(endDate: date)),
              ),
            ],
          ],
        );
      }),
    );
  }

  Widget _dropdown({
    required double width,
    required String label,
    required IconData? icon,
    required String value,
    required Map<String, String> options,
    required ValueChanged<String> onChanged,
  }) =>
      SizedBox(
        width: width,
        child: DropdownButtonFormField<String>(
          key: ValueKey('$label:$value'),
          initialValue: value,
          isDense: true,
          decoration: _fieldDecoration(label, icon).copyWith(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          ),
          items: options.entries
              .map((entry) => DropdownMenuItem(
                    value: entry.key,
                    child: Text(entry.value, overflow: TextOverflow.ellipsis),
                  ))
              .toList(),
          onChanged: (value) {
            if (value != null) onChanged(value);
          },
        ),
      );

  Widget _dateButton({
    required BuildContext context,
    required double width,
    required String label,
    required IconData icon,
    required DateTime? value,
    required ValueChanged<DateTime> onPicked,
    DateTime? firstDate,
  }) =>
      SizedBox(
        width: width,
        child: OutlinedButton.icon(
          style: OutlinedButton.styleFrom(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          ),
          onPressed: () async {
            final now = DateTime.now();
            final selected = await showDatePicker(
              context: context,
              initialDate: value ?? firstDate ?? now,
              firstDate: firstDate ?? DateTime(2020),
              lastDate: DateTime(now.year + 5),
            );
            if (selected != null) onPicked(selected);
          },
          icon: Icon(icon, size: 20),
          label: Text(
            value == null
                ? label
                : '$label ${DateFormat('yyyy-MM-dd').format(value)}',
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
      );
}

class _SortDirectionButton extends StatelessWidget {
  const _SortDirectionButton({
    required this.compact,
    required this.sortOrder,
    required this.onPressed,
  });

  final bool compact;
  final String sortOrder;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final descending = sortOrder == 'desc';
    return Tooltip(
      message: descending ? 'Descending' : 'Ascending',
      child: IconButton.filledTonal(
        constraints: const BoxConstraints.tightFor(width: 44, height: 44),
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        icon: Icon(descending ? Icons.arrow_downward : Icons.arrow_upward,
            size: compact ? 20 : 24),
      ),
    );
  }
}

class _GroupByStatusCheckbox extends StatelessWidget {
  const _GroupByStatusCheckbox({
    required this.width,
    required this.selected,
    required this.compact,
    required this.onChanged,
  });

  final double width;
  final bool selected;
  final bool compact;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    final content = compact
        ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(
              selected ? Icons.check_box : Icons.check_box_outline_blank,
              size: 18,
              color: selected ? const Color(0xFF2563EB) : null,
            ),
            const SizedBox(width: 5),
            Flexible(
              child: Text(
                'Group',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: selected ? const Color(0xFF2563EB) : null,
                ),
              ),
            ),
          ])
        : Row(mainAxisSize: MainAxisSize.min, children: [
            Checkbox(
              value: selected,
              visualDensity: VisualDensity.compact,
              onChanged: onChanged == null
                  ? null
                  : (value) => onChanged!(value ?? false),
            ),
            const Text('Group by status',
                style: TextStyle(fontWeight: FontWeight.w700)),
          ]);
    return Tooltip(
      message: 'Group by status',
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onChanged == null ? null : () => onChanged!(!selected),
        child: Container(
          width: width,
          constraints: const BoxConstraints(minHeight: 44),
          alignment: Alignment.center,
          padding: compact
              ? EdgeInsets.zero
              : const EdgeInsets.only(left: 8, right: 12),
          decoration: BoxDecoration(
            color: selected ? const Color(0xFFE8F1FF) : const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color:
                  selected ? const Color(0xFF2563EB) : const Color(0xFFDCE4F0),
            ),
          ),
          child: content,
        ),
      ),
    );
  }
}

class _CreatedAgeChip extends StatelessWidget {
  const _CreatedAgeChip({required this.configuration});

  final AdminConfiguration configuration;

  @override
  Widget build(BuildContext context) {
    final age = _elapsedAge(configuration.createdAt)?.value;
    if (age == null) return const SizedBox.shrink();
    return Container(
      constraints: const BoxConstraints(minWidth: 98),
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0xFFBFDBFE)),
      ),
      child: Text(
        'Created at $age ago',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: Color(0xFF1D4ED8),
          fontSize: 11,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

class _ConfigurationCardActions extends StatelessWidget {
  const _ConfigurationCardActions({
    required this.isDeleting,
    required this.onView,
    required this.onEdit,
    required this.onDelete,
  });

  final bool isDeleting;
  final VoidCallback onView;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) =>
      Row(mainAxisSize: MainAxisSize.min, children: [
        _compactAction(
          tooltip: 'View details',
          icon: const Icon(Icons.visibility_outlined),
          onPressed: onView,
        ),
        _compactAction(
          tooltip: 'Edit configuration',
          icon: const Icon(Icons.edit_outlined),
          onPressed: onEdit,
        ),
        _compactAction(
          tooltip: 'Delete configuration',
          icon: isDeleting
              ? const SizedBox.square(
                  dimension: 14,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.delete_outline, color: Colors.red),
          onPressed: isDeleting ? null : onDelete,
        ),
      ]);

  Widget _compactAction({
    required String tooltip,
    required Widget icon,
    required VoidCallback? onPressed,
  }) =>
      SizedBox.square(
        dimension: 30,
        child: IconButton.filledTonal(
          tooltip: tooltip,
          onPressed: onPressed,
          icon: icon,
          iconSize: 16,
          padding: EdgeInsets.zero,
          visualDensity: VisualDensity.compact,
          style: IconButton.styleFrom(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
      );
}

class _InfoTileData {
  const _InfoTileData(this.icon, this.label, this.value);

  final IconData icon;
  final String label;
  final String value;
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({required this.item});

  final _InfoTileData item;

  @override
  Widget build(BuildContext context) => Container(
        constraints: const BoxConstraints(minHeight: 58),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Icon(item.icon, size: 16, color: const Color(0xFF64748B)),
          const SizedBox(width: 6),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(item.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Color(0xFF64748B),
                        fontSize: 11,
                        fontWeight: FontWeight.w700)),
                const SizedBox(height: 2),
                Text(item.value,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w700)),
              ])),
        ]),
      );
}

class _StatusSectionHeader extends StatelessWidget {
  const _StatusSectionHeader({
    required this.status,
    required this.count,
  });

  final String status;
  final int count;

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Row(children: [
          _StatusBadge(status),
          const SizedBox(width: 10),
          Text(
            '$count configuration${count == 1 ? '' : 's'}',
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
        ]),
      );
}

class _ConfigurationAgeBlocks extends StatelessWidget {
  const _ConfigurationAgeBlocks({required this.configuration});

  final AdminConfiguration configuration;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final compact = constraints.maxWidth < 460;
      final hasUpdate = _hasDistinctUpdate(configuration);
      final width = compact || !hasUpdate
          ? constraints.maxWidth
          : (constraints.maxWidth - 10) / 2;
      return Wrap(spacing: 10, runSpacing: 10, children: [
        _AgeFocusBlock(
          width: width,
          label: 'Created ago',
          icon: Icons.add_circle_outline,
          value: _elapsedAge(configuration.createdAt),
          color: const Color(0xFF2563EB),
          background: const Color(0xFFEFF6FF),
        ),
        if (hasUpdate)
          _AgeFocusBlock(
            width: width,
            label: 'Updated ago',
            icon: Icons.update,
            value: _elapsedAge(configuration.updatedAt),
            color: const Color(0xFF0F766E),
            background: const Color(0xFFECFDF5),
          ),
      ]);
    });
  }
}

class _AgeFocusBlock extends StatelessWidget {
  const _AgeFocusBlock({
    required this.width,
    required this.label,
    required this.icon,
    required this.value,
    required this.color,
    required this.background,
  });

  final double width;
  final String label;
  final IconData icon;
  final _ElapsedAge? value;
  final Color color;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: .28)),
      ),
      child: Row(children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(width: 10),
        Expanded(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(label,
                style: TextStyle(
                    color: color, fontSize: 12, fontWeight: FontWeight.w800)),
            const SizedBox(height: 2),
            Text(
              value?.value ?? '-',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: color, fontSize: 26, fontWeight: FontWeight.w900),
            ),
          ]),
        ),
      ]),
    );
  }
}

class _PendingAgePanel extends StatelessWidget {
  const _PendingAgePanel({required this.configuration});

  final AdminConfiguration configuration;

  @override
  Widget build(BuildContext context) {
    final age = _pendingAge(configuration);
    if (age == null) return const SizedBox.shrink();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF7ED),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFF97316)),
      ),
      child: Row(children: [
        const Icon(Icons.priority_high_rounded,
            color: Color(0xFFC2410C), size: 28),
        const SizedBox(width: 10),
        Text(
          age.value,
          style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              color: Color(0xFF9A3412)),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            'pending',
            style: TextStyle(
              color: Colors.orange.shade900,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ]),
    );
  }
}

class _PendingAgePill extends StatelessWidget {
  const _PendingAgePill({required this.configuration});

  final AdminConfiguration configuration;

  @override
  Widget build(BuildContext context) {
    final age = _pendingAge(configuration);
    if (age == null) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: const Color(0xFFFFEDD5),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        '${age.value} pending',
        style: const TextStyle(
          color: Color(0xFF9A3412),
          fontSize: 11,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _PendingAge {
  const _PendingAge(this.value);

  final String value;
}

_PendingAge? _pendingAge(AdminConfiguration configuration) {
  if (configuration.status != 'pending') return null;
  final start = configuration.updatedAt ??
      configuration.createdAt ??
      configuration.dateOrdered;
  if (start == null) return null;
  final duration = DateTime.now().difference(start.toLocal());
  if (duration.inDays >= 1) {
    return _PendingAge('${duration.inDays}d');
  }
  if (duration.inHours >= 1) {
    return _PendingAge('${duration.inHours}h');
  }
  final minutes = duration.inMinutes.clamp(0, 59);
  return _PendingAge('${minutes}m');
}

class _ElapsedAge {
  const _ElapsedAge(this.value);

  final String value;
}

_ElapsedAge? _elapsedAge(DateTime? date) {
  if (date == null) return null;
  final duration = DateTime.now().difference(date.toLocal());
  if (duration.inDays >= 1) {
    return _ElapsedAge('${duration.inDays}d');
  }
  if (duration.inHours >= 1) {
    return _ElapsedAge('${duration.inHours}h');
  }
  final minutes = duration.inMinutes.clamp(0, 59);
  return _ElapsedAge('${minutes}m');
}

bool _hasDistinctUpdate(AdminConfiguration configuration) {
  final created = configuration.createdAt;
  final updated = configuration.updatedAt;
  if (updated == null) return false;
  if (created == null) return true;
  return updated.difference(created).abs().inMinutes >= 1;
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
          _ConfigurationAgeBlocks(configuration: configuration),
          const SizedBox(height: 16),
          _PlainSectionBox(
            title: 'Configuration summary',
            children: [
              _plainInfoGrid([
                _PlainInfo('Status', _titleCase(configuration.status)),
                _PlainInfo('Products', '${configuration.cart.length}'),
                _PlainInfo('Created', _friendlyDate(configuration.createdAt)),
                if (_hasDistinctUpdate(configuration))
                  _PlainInfo('Updated', _friendlyDate(configuration.updatedAt)),
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
            _ConfigurationAgeBlocks(configuration: widget.configuration),
            const SizedBox(height: 18),
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

InputDecoration _fieldDecoration(String label, IconData? icon) =>
    InputDecoration(
      labelText: label,
      prefixIcon: icon == null ? null : Icon(icon, size: 20),
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
              _detailField('Created', _friendlyDate(user.createdAt),
                  Icons.add_circle_outline, width),
              _detailField('Updated', _friendlyDate(user.updatedAt),
                  Icons.update, width),
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
      {required this.width, required this.showIcon});
  final String label;
  final int total;
  final IconData icon;
  final Color color;
  final double width;
  final bool showIcon;

  @override
  Widget build(BuildContext context) => Container(
        width: width,
        padding: EdgeInsets.all(showIcon ? 18 : 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Row(children: [
          if (showIcon) ...[
            CircleAvatar(
                backgroundColor: color.withValues(alpha: .12),
                child: Icon(icon, color: color)),
            const SizedBox(width: 14),
          ],
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text('$total',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: showIcon ? 25 : 21,
                        fontWeight: FontWeight.w900,
                        color: color)),
                Text(label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ])),
        ]),
      );
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge(this.status, {this.compact = false});
  final String status;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final color = switch (status) {
      'done' => Colors.green,
      'pending' => Colors.orange,
      _ => Colors.blue,
    };
    return _Badge(label: _titleCase(status), color: color, compact: compact);
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
  const _Badge({
    required this.label,
    required this.color,
    this.compact = false,
  });
  final String label;
  final MaterialColor color;
  final bool compact;

  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.symmetric(
          horizontal: compact ? 7 : 10,
          vertical: compact ? 3 : 5,
        ),
        decoration: BoxDecoration(
          color: color.withValues(alpha: .12),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: color.shade700,
              fontSize: compact ? 11 : null,
              fontWeight: FontWeight.w700,
            )),
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
