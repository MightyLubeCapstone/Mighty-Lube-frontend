import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/admin_models.dart';
import '../../repositories/admin_repository.dart';

// ===========================================================
// ACTIVITY LOGS DRAWER
//
// Right side endDrawer on the Admin dashboard.
// Shows business activity logs from the server with
// search, entity type + date filters and infinite scroll.
// ===========================================================

class ActivityLogsDrawer extends StatefulWidget {
  const ActivityLogsDrawer({
    super.key,
  });

  @override
  State<ActivityLogsDrawer> createState() =>
      _ActivityLogsDrawerState();
}

enum _DateRange {
  today,
  week,
  month,
  all,
}

class _ActivityLogsDrawerState
    extends State<ActivityLogsDrawer> {
  static const Color navy =
  Color(0xFF17223B);

  static const int pageSize = 30;

  final TextEditingController _searchController =
  TextEditingController();

  final ScrollController _scrollController =
  ScrollController();

  Timer? _searchDebounce;

  final List<ActivityLog> _logs = [];

  String? _entityType;
  _DateRange _dateRange = _DateRange.all;

  int _page = 1;
  bool _hasMore = true;
  bool _isLoading = false;
  String? _error;

  // Ignores responses from older requests after filters change.
  int _requestID = 0;

  String? _expandedID;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(
      _onScroll,
    );

    _load(reset: true);
  }

  @override
  void dispose() {
    _searchDebounce?.cancel();
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // =========================================================
  // DATA
  // =========================================================

  DateTime? get _fromDate {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    switch (_dateRange) {
      case _DateRange.today:
        return today;

      case _DateRange.week:
        return today.subtract(const Duration(days: 6));

      case _DateRange.month:
        return today.subtract(const Duration(days: 29));

      case _DateRange.all:
        return null;
    }
  }

  Future<void> _load({
    bool reset = false,
  }) async {
    if (!reset && (_isLoading || !_hasMore)) {
      return;
    }

    final requestID = ++_requestID;
    final page = reset ? 1 : _page + 1;

    setState(() {
      _isLoading = true;
      _error = null;

      if (reset) {
        _logs.clear();
        _hasMore = true;
        _expandedID = null;
      }
    });

    final response = await AdminRepository.getActivityLogs(
      filters: ActivityLogFilters(
        page: page,
        limit: pageSize,
        entityType: _entityType,
        from: _fromDate,
        search: _searchController.text,
      ),
    );

    if (!mounted || requestID != _requestID) {
      return;
    }

    setState(() {
      _isLoading = false;

      if (!response.success || response.data == null) {
        _error = response.message ?? 'Failed to load activity logs';
        return;
      }

      _page = page;
      _logs.addAll(response.data!.data);
      _hasMore = response.data!.hasMore;
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _load();
    }
  }

  void _onSearchChanged(
      String _,
      ) {
    _searchDebounce?.cancel();

    _searchDebounce = Timer(
      const Duration(milliseconds: 400),
          () => _load(reset: true),
    );
  }

  // =========================================================
  // BUILD
  // =========================================================

  @override
  Widget build(
      BuildContext context,
      ) {
    final screenWidth = MediaQuery.sizeOf(context).width;

    final width = screenWidth >= 620
        ? 460.0
        : screenWidth * 0.9;

    return Drawer(
      width: width,
      backgroundColor: const Color(0xFFF4F7FB),
      shape: const RoundedRectangleBorder(),
      child: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildFilters(),
            const Divider(
              height: 1,
              color: Color(0xFFE2E8F0),
            ),
            Expanded(
              child: _buildBody(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: navy,
      padding: const EdgeInsets.fromLTRB(20, 12, 8, 12),
      child: Row(
        children: [
          const Icon(
            Icons.history,
            color: Colors.white,
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Activity Logs',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          IconButton(
            tooltip: 'Refresh',
            onPressed: _isLoading
                ? null
                : () => _load(reset: true),
            icon: const Icon(
              Icons.refresh,
              color: Colors.white,
            ),
          ),
          IconButton(
            tooltip: 'Close',
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.close,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  onChanged: _onSearchChanged,
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: 'Search user, RFQ, action...',
                    prefixIcon: const Icon(
                      Icons.search,
                      size: 20,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: 150,
                child: DropdownButtonFormField<String?>(
                  initialValue: _entityType,
                  isDense: true,
                  isExpanded: true,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  items: [
                    const DropdownMenuItem<String?>(
                      value: null,
                      child: Text('All'),
                    ),
                    for (final type in ActivityLogEntityType.values)
                      DropdownMenuItem<String?>(
                        value: type,
                        child: Text(
                          ActivityLogEntityType.label(type),
                        ),
                      ),
                  ],
                  onChanged: (value) {
                    _entityType = value;
                    _load(reset: true);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: [
              _dateChip(_DateRange.today, 'Today'),
              _dateChip(_DateRange.week, '7 days'),
              _dateChip(_DateRange.month, '30 days'),
              _dateChip(_DateRange.all, 'All'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _dateChip(
      _DateRange range,
      String label,
      ) {
    return ChoiceChip(
      label: Text(label),
      selected: _dateRange == range,
      visualDensity: VisualDensity.compact,
      onSelected: (_) {
        if (_dateRange == range) {
          return;
        }

        _dateRange = range;
        _load(reset: true);
      },
    );
  }

  Widget _buildBody() {
    if (_logs.isEmpty && _isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_logs.isEmpty && _error != null) {
      return _buildMessage(
        icon: Icons.error_outline,
        text: _error!,
        showRetry: true,
      );
    }

    if (_logs.isEmpty) {
      return _buildMessage(
        icon: Icons.inbox_outlined,
        text: 'No activity yet',
      );
    }

    final items = _groupedItems();

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 16),
      itemCount: items.length + 1,
      itemBuilder: (context, index) {
        if (index == items.length) {
          return _buildFooter();
        }

        final item = items[index];

        if (item is String) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(4, 14, 4, 6),
            child: Text(
              item,
              style: const TextStyle(
                color: Color(0xFF64748B),
                fontSize: 12,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.4,
              ),
            ),
          );
        }

        return _ActivityLogTile(
          log: item as ActivityLog,
          expanded: _expandedID == item.id,
          onTap: () {
            setState(() {
              _expandedID =
              _expandedID == item.id ? null : item.id;
            });
          },
        );
      },
    );
  }

  // Date headers (String) mixed with logs (ActivityLog).
  List<Object> _groupedItems() {
    final items = <Object>[];
    String? lastHeader;

    for (final log in _logs) {
      final header = _dayHeader(log.createdAt);

      if (header != lastHeader) {
        items.add(header);
        lastHeader = header;
      }

      items.add(log);
    }

    return items;
  }

  String _dayHeader(
      DateTime? date,
      ) {
    if (date == null) {
      return 'UNKNOWN DATE';
    }

    final local = date.toLocal();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final day = DateTime(local.year, local.month, local.day);
    final difference = today.difference(day).inDays;

    if (difference == 0) {
      return 'TODAY';
    }

    if (difference == 1) {
      return 'YESTERDAY';
    }

    return DateFormat('d MMM yyyy').format(local).toUpperCase();
  }

  Widget _buildFooter() {
    if (_isLoading) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: SizedBox(
            width: 22,
            height: 22,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      );
    }

    if (_error != null) {
      return Center(
        child: TextButton.icon(
          onPressed: _load,
          icon: const Icon(Icons.refresh),
          label: const Text('Retry'),
        ),
      );
    }

    // Page did not fill the list, so scroll can't trigger more.
    if (_hasMore) {
      return Center(
        child: TextButton(
          onPressed: _load,
          child: const Text('Load more'),
        ),
      );
    }

    return const Padding(
      padding: EdgeInsets.all(16),
      child: Center(
        child: Text(
          'No more activity',
          style: TextStyle(
            color: Color(0xFF94A3B8),
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildMessage({
    required IconData icon,
    required String text,
    bool showRetry = false,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 40,
              color: const Color(0xFF94A3B8),
            ),
            const SizedBox(height: 10),
            Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF475569),
              ),
            ),
            if (showRetry) ...[
              const SizedBox(height: 10),
              OutlinedButton.icon(
                onPressed: () => _load(reset: true),
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ===========================================================
// ACTIVITY LOG TILE
// ===========================================================

class _ActivityLogTile extends StatelessWidget {
  const _ActivityLogTile({
    required this.log,
    required this.expanded,
    required this.onTap,
  });

  final ActivityLog log;
  final bool expanded;
  final VoidCallback onTap;

  static IconData _icon(
      String type,
      ) {
    switch (type) {
      case ActivityLogEntityType.auth:
        return Icons.lock_outline;

      case ActivityLogEntityType.configuration:
        return Icons.tune;

      case ActivityLogEntityType.user:
        return Icons.person_outline;

      case ActivityLogEntityType.rfq:
        return Icons.description_outlined;

      default:
        return Icons.bolt_outlined;
    }
  }

  static Color _color(
      String type,
      ) {
    switch (type) {
      case ActivityLogEntityType.auth:
        return const Color(0xFF475569);

      case ActivityLogEntityType.configuration:
        return const Color(0xFF2563EB);

      case ActivityLogEntityType.user:
        return const Color(0xFF7C3AED);

      case ActivityLogEntityType.rfq:
        return const Color(0xFF15803D);

      default:
        return const Color(0xFFD97706);
    }
  }

  static String _relativeTime(
      DateTime? date,
      ) {
    if (date == null) {
      return '—';
    }

    final difference = DateTime.now().difference(date.toLocal());

    if (difference.inMinutes < 1) {
      return 'Just now';
    }

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min ago';
    }

    if (difference.inHours < 24) {
      return '${difference.inHours} hr ago';
    }

    return DateFormat('h:mm a').format(date.toLocal());
  }

  @override
  Widget build(
      BuildContext context,
      ) {
    final color = _color(log.entityType);

    final subtitle = [
      log.actorDisplay,
      if (log.entityLabel != null) log.entityLabel!,
    ].join(' · ');

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: expanded
              ? color.withOpacity(0.5)
              : const Color(0xFFE2E8F0),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: Icon(
                        _icon(log.entityType),
                        size: 18,
                        color: color,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            log.message.isEmpty
                                ? log.action
                                : log.message,
                            style: const TextStyle(
                              color: Color(0xFF0F172A),
                              fontWeight: FontWeight.w700,
                              fontSize: 13.5,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            subtitle,
                            style: const TextStyle(
                              color: Color(0xFF475569),
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            _relativeTime(log.createdAt),
                            style: const TextStyle(
                              color: Color(0xFF94A3B8),
                              fontSize: 11.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      expanded
                          ? Icons.expand_less
                          : Icons.expand_more,
                      size: 20,
                      color: const Color(0xFF94A3B8),
                    ),
                  ],
                ),
                if (expanded) _buildDetails(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetails() {
    final rows = <MapEntry<String, String>>[
      MapEntry('Action', log.action),
      MapEntry(
        'Time',
        log.createdAt == null
            ? '—'
            : DateFormat('d MMM yyyy, h:mm:ss a')
            .format(log.createdAt!.toLocal()),
      ),
      if (log.actorEmail != null) MapEntry('Email', log.actorEmail!),
      if (log.entityID != null) MapEntry('Item ID', log.entityID!),
      for (final entry in log.metadata.entries)
        MapEntry(_titleCase(entry.key), entry.value?.toString() ?? '—'),
      if (log.ipAddress != null) MapEntry('IP', log.ipAddress!),
    ];

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          for (final row in rows)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 90,
                    child: Text(
                      row.key,
                      style: const TextStyle(
                        color: Color(0xFF64748B),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Expanded(
                    child: SelectableText(
                      row.value,
                      style: const TextStyle(
                        color: Color(0xFF0F172A),
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  static String _titleCase(
      String key,
      ) {
    if (key.isEmpty) {
      return key;
    }

    return key[0].toUpperCase() + key.substring(1);
  }
}
