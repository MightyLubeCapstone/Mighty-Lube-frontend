import 'dart:async';

import 'package:flutter/material.dart';

import '../../models/admin_models.dart';
import '../common/admin_status_style.dart';

class ConfigurationTable extends StatefulWidget {
  const ConfigurationTable({
    super.key,
    required this.items,
    required this.users,
    required this.updatingConfigurationIDs,
    required this.deletingConfigurationIDs,
    required this.imageCountFor,
    required this.onStatusChanged,
    required this.onViewConfiguration,
    required this.onViewImages,
    required this.onEditConfiguration,
    required this.onDeleteConfiguration,
    required this.onViewUser,
    required this.onViewProject,
  });

  final List<AdminConfiguration> items;
  final List<AdminUser> users;

  final Set<String> updatingConfigurationIDs;
  final Set<String> deletingConfigurationIDs;

  final int Function(AdminConfiguration configuration) imageCountFor;

  final void Function(
      AdminConfiguration configuration,
      String? status,
      ) onStatusChanged;

  final void Function(
      AdminConfiguration configuration,
      ) onViewConfiguration;

  final void Function(
      AdminConfiguration configuration,
      ) onViewImages;

  final void Function(
      AdminConfiguration configuration,
      ) onEditConfiguration;

  final void Function(
      AdminConfiguration configuration,
      ) onDeleteConfiguration;

  final void Function(
      AdminUser user,
      ) onViewUser;

  final void Function(
      AdminProjectGroup project,
      ) onViewProject;

  @override
  State<ConfigurationTable> createState() =>
      _ConfigurationTableState();
}

class _ConfigurationTableState extends State<ConfigurationTable> {
  static const List<String> _statuses =
      AdminWorkflowStatus.values;

  Timer? _liveTimer;

  // Project groups the admin has opened.
  final Set<String> _expandedProjects = {};

  // =========================================================
  // SCROLL CONTROLLERS
  // =========================================================

  final ScrollController _verticalScrollController =
  ScrollController();

  final ScrollController _horizontalScrollController =
  ScrollController();

  final Map<String, DateTime> _localStatusStartedAt = {};

  final Map<String, String> _localStatuses = {};

  @override
  void initState() {
    super.initState();
    _startLiveTimer();
  }

  @override
  void dispose() {
    _liveTimer?.cancel();

    _verticalScrollController.dispose();
    _horizontalScrollController.dispose();

    super.dispose();
  }

  // =========================================================
  // LIVE TIMER
  // =========================================================

  void _startLiveTimer() {
    _liveTimer?.cancel();

    _liveTimer = Timer.periodic(
      const Duration(seconds: 1),
          (_) {
        if (!mounted) {
          return;
        }

        setState(() {});
      },
    );
  }

  @override
  void didUpdateWidget(
      covariant ConfigurationTable oldWidget,
      ) {
    super.didUpdateWidget(oldWidget);
    _syncLocalStateWithServer();
  }

  void _syncLocalStateWithServer() {
    final configurationIDs =
    widget.items.map((item) => item.id).toSet();

    _localStatuses.removeWhere(
          (configurationID, _) =>
      !configurationIDs.contains(configurationID),
    );

    _localStatusStartedAt.removeWhere(
          (configurationID, _) =>
      !configurationIDs.contains(configurationID),
    );

    for (final item in widget.items) {
      final localStatus =
      _localStatuses[item.id];

      if (localStatus == null) {
        continue;
      }

      final serverStatus =
          item.adminWorkflowStatus ?? 'requested';

      if (serverStatus == localStatus) {
        final hasServerStartTime =
            _serverStatusStartDate(
              item,
              serverStatus,
            ) !=
                null;

        if (serverStatus == 'done' ||
            hasServerStartTime) {
          _localStatuses.remove(item.id);
          _localStatusStartedAt.remove(item.id);
        }
      }
    }
  }

  // =========================================================
  // BUILD
  // =========================================================

  @override
  Widget build(BuildContext context) {
    return _tableContainer(
      context,
      empty: widget.items.isEmpty,
      emptyText: 'No configurations found.',
      table: DataTable(
        columnSpacing: _columnSpacing(context),
        horizontalMargin: 12,
        headingRowHeight: 44,
        dataRowMinHeight: 92,
        dataRowMaxHeight: 112,

        // =====================================================
        // TEMPORARY DEBUG GRID
        // =====================================================
        // border: const TableBorder(
        //   top: BorderSide(
        //     color: Colors.red,
        //     width: 1,
        //   ),
        //   bottom: BorderSide(
        //     color: Colors.red,
        //     width: 1,
        //   ),
        //   left: BorderSide(
        //     color: Colors.red,
        //     width: 1,
        //   ),
        //   right: BorderSide(
        //     color: Colors.red,
        //     width: 1,
        //   ),
        //   horizontalInside: BorderSide(
        //     color: Colors.red,
        //     width: 1,
        //   ),
        //   verticalInside: BorderSide(
        //     color: Colors.red,
        //     width: 1,
        //   ),
        // ),

        dividerThickness: 0,

        columns: const [
          DataColumn(
            label: SizedBox(
              width: 130,
              child: Center(
                child: Text(
                  'RFQ #',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          DataColumn(
            label: SizedBox(
              width: 150,
              child: Center(
                child: Text(
                  'Configuration',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          DataColumn(
            label: SizedBox(
              width: 280,
              child: Center(
                child: Text(
                  'Product',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          DataColumn(
            label: SizedBox(
              width: 42,
              child: Center(
                child: Text(
                  'QTY',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          DataColumn(
            label: SizedBox(
              width: 320,
              child: Center(
                child: Text(
                  'Configuration dates',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          DataColumn(
            label: Center(
              child: SizedBox(
                width: 190,
                child: Text(
                  'Admin status',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          DataColumn(
            label: SizedBox(
              width: 190,
              child: Center(
                child: Text(
                  'User',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          DataColumn(
            label: SizedBox(
              width: 190,
              child: Center(
                child: Text(
                  'Actions',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],

        rows: _tableRows(context),
      ),
    );
  }

  // =========================================================
  // ROWS
  //
  // Standalone RFQ -> one normal row.
  // Project        -> purple header row, and its RFQ rows
  //                   underneath when expanded.
  // =========================================================

  List<DataRow> _tableRows(
      BuildContext context,
      ) {
    final rows = <DataRow>[];

    for (final entry
    in groupConfigurationsByProject(widget.items)) {
      if (entry is AdminConfiguration) {
        rows.add(
          _configurationRow(
            context,
            entry,
          ),
        );

        continue;
      }

      final group = entry as AdminProjectGroup;

      final expanded =
      _expandedProjects.contains(group.key);

      rows.add(
        _projectHeaderRow(
          group,
          expanded,
        ),
      );

      if (expanded) {
        for (final item in group.items) {
          rows.add(
            _configurationRow(
              context,
              item,
              inProject: true,
            ),
          );
        }
      }
    }

    return rows;
  }

  void _toggleProject(
      AdminProjectGroup group,
      ) {
    setState(() {
      if (!_expandedProjects.remove(group.key)) {
        _expandedProjects.add(group.key);
      }
    });
  }

  // =========================================================
  // PROJECT HEADER ROW
  // =========================================================

  DataRow _projectHeaderRow(
      AdminProjectGroup group,
      bool expanded,
      ) {
    final count = group.items.length;

    DataCell toggleCell(
        Widget child,
        ) {
      return DataCell(
        child,
        onTap: () => _toggleProject(group),
      );
    }

    return DataRow(
      color: WidgetStateProperty.resolveWith<Color?>(
            (states) {
          if (states.contains(WidgetState.hovered)) {
            return AdminStatusStyle.projectHover;
          }

          return AdminStatusStyle.projectBackground;
        },
      ),
      cells: [
        // =====================================================
        // PROJECT NUMBER
        // =====================================================
        toggleCell(
          _purpleEdge(
            width: 130,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  expanded
                      ? Icons.keyboard_arrow_down
                      : Icons.keyboard_arrow_right,
                  color: AdminStatusStyle.projectColor,
                  size: 20,
                ),
                const Icon(
                  Icons.folder_outlined,
                  color: AdminStatusStyle.projectColor,
                  size: 18,
                ),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    group.projectNumberLabel ?? 'Project',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AdminStatusStyle.projectColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // =====================================================
        // PROJECT NAME
        // =====================================================
        toggleCell(
          SizedBox(
            width: 150,
            child: Center(
              child: Tooltip(
                message: group.projectName,
                child: Text(
                  group.projectName,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AdminStatusStyle.projectColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ),
        ),

        // =====================================================
        // RFQ COUNT
        // =====================================================
        toggleCell(
          SizedBox(
            width: 280,
            child: Center(
              child: Text(
                '$count RFQ${count == 1 ? '' : 's'}'
                    ' • ${expanded ? 'click to collapse' : 'click to expand'}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF5B21B6),
                ),
              ),
            ),
          ),
        ),

        // =====================================================
        // TOTAL QTY
        // =====================================================
        toggleCell(
          SizedBox(
            width: 42,
            child: Center(
              child: Text(
                '${group.totalQuantity}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),

        // =====================================================
        // SUBMITTED
        // =====================================================
        toggleCell(
          SizedBox(
            width: 320,
            child: Center(
              child: Text(
                'Submitted: ${_date(group.submittedAt)}',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF0F172A),
                ),
              ),
            ),
          ),
        ),

        // =====================================================
        // STATUS SUMMARY
        // =====================================================
        toggleCell(
          SizedBox(
            width: 190,
            child: Center(
              child: AdminProjectStatusSummary(
                group: group,
              ),
            ),
          ),
        ),

        // =====================================================
        // USER
        // =====================================================
        DataCell(
          _configurationUserCell(group.items.first),
        ),

        // =====================================================
        // ACTIONS
        // =====================================================
        DataCell(
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  tooltip: 'View project',
                  onPressed: () =>
                      widget.onViewProject(group),
                  icon: const Icon(
                    Icons.visibility_outlined,
                    color: AdminStatusStyle.projectColor,
                  ),
                ),
                IconButton(
                  tooltip: expanded
                      ? 'Collapse project'
                      : 'Expand project',
                  onPressed: () => _toggleProject(group),
                  icon: Icon(
                    expanded
                        ? Icons.unfold_less
                        : Icons.unfold_more,
                    color: AdminStatusStyle.projectColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Purple bar on the left edge marks project rows.
  Widget _purpleEdge({
    required double width,
    required Widget child,
  }) {
    return SizedBox(
      width: width,
      child: Row(
        children: [
          Container(
            width: 4,
            height: 64,
            decoration: BoxDecoration(
              color: AdminStatusStyle.projectColor,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Center(
              child: child,
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // RFQ CELL
  // =========================================================

  Widget _rfqCell(
      AdminConfiguration item,
      bool inProject,
      ) {
    final rfq = Text(
      item.rfqLabel ?? '—',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w800,
        color: Color(0xFF0F172A),
      ),
    );

    if (inProject) {
      return _purpleEdge(
        width: 130,
        child: rfq,
      );
    }

    return SizedBox(
      width: 130,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          rfq,
          const SizedBox(height: 4),
          const AdminStandaloneTag(),
        ],
      ),
    );
  }

  // =========================================================
  // CONFIGURATION ROW
  // =========================================================

  DataRow _configurationRow(
      BuildContext context,
      AdminConfiguration item, {
        bool inProject = false,
      }) {
    final adminStatus =
    _effectiveStatus(item);

    final imageCount =
    widget.imageCountFor(item);

    return DataRow(
      color: WidgetStateProperty.resolveWith<Color?>(
            (states) {
          if (states.contains(WidgetState.hovered)) {
            return _rowHoverColor(adminStatus);
          }

          return _rowColor(adminStatus);
        },
      ),
      cells: [
        // =====================================================
        // RFQ NUMBER
        // =====================================================
        DataCell(
          _rfqCell(
            item,
            inProject,
          ),
        ),

        // =====================================================
        // CONFIGURATION
        // =====================================================
        DataCell(
          SizedBox(
            width: 150,
            child: Center(
              child: Tooltip(
                message: item.name,
                child: Text(
                  item.name,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ),

        // =====================================================
        // PRODUCT
        // =====================================================
        DataCell(
          SizedBox(
            width: 280,
            child: Center(
              child: Text(
                item.productName.trim().isNotEmpty
                    ? item.productName
                    : item.productType,
                maxLines: 3,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  height: 1.25,
                ),
              ),
            ),
          ),
        ),

        // =====================================================
        // QTY
        // =====================================================
        DataCell(
          SizedBox(
            width: 42,
            child: Center(
              child: Text(
                '${item.numRequested}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),

        // =====================================================
        // DATES
        // =====================================================
        DataCell(
          _configurationDatesCell(item),
        ),

        // =====================================================
        // ADMIN STATUS
        // =====================================================
        DataCell(
          widget.updatingConfigurationIDs.contains(item.id)
              ? Center(
            child: SizedBox(
              width: 190,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox.square(
                    dimension: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  ),
                  if (adminStatus != 'done') ...[
                    const SizedBox(height: 5),
                    _adminStatusAge(item, adminStatus,),
                  ],
                ],
              ),
            ),
          )
              : Center(
            child: SizedBox(
              width: 190,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment:
                MainAxisAlignment.center,
                crossAxisAlignment:
                CrossAxisAlignment.center,
                children: [
                  PopupMenuButton<String>(
                    initialValue:
                    _statuses.contains(adminStatus)
                        ? adminStatus
                        : null,
                    padding: EdgeInsets.zero,
                    onSelected: (value) {
                      _handleStatusChanged(
                        item,
                        value,
                      );
                    },
                    itemBuilder: (context) {
                      return _statuses.map((value) {
                        return PopupMenuItem<String>(
                          value: value,
                          child: Text(
                            AdminWorkflowStatus.label(value),
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      }).toList();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius:
                        BorderRadius.circular(8),
                        border: Border.all(
                          color: const Color(0xFFE2E8F0),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Text(
                              AdminWorkflowStatus.label(adminStatus),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(width: 3),
                          const Icon(
                            Icons.arrow_drop_down,
                            size: 22,
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (adminStatus != 'done') ...[
                    const SizedBox(height: 2),
                    _adminStatusAge(
                      item,
                      adminStatus,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),

        // =====================================================
        // USER
        // =====================================================
        DataCell(
          _configurationUserCell(item),
        ),

        // =====================================================
        // ACTIONS
        // =====================================================
        DataCell(
          widget.deletingConfigurationIDs.contains(item.id)
              ? const Center(
            child: SizedBox.square(
              dimension: 22,
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ),
          )
              : Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  tooltip: 'View details',
                  onPressed: () =>
                      widget.onViewConfiguration(item),
                  icon: const Icon(
                    Icons.visibility_outlined,
                  ),
                ),
                if (imageCount > 0)
                  Tooltip(
                    message:
                    '$imageCount attached image${imageCount == 1 ? '' : 's'}',
                    child: TextButton.icon(
                      onPressed: () =>
                          widget.onViewImages(item),
                      icon: const Icon(
                        Icons.photo_library_outlined,
                        size: 18,
                      ),
                      label: Text('$imageCount'),
                    ),
                  ),
                IconButton(
                  tooltip: 'Edit configuration',
                  onPressed: () =>
                      widget.onEditConfiguration(item),
                  icon: const Icon(
                    Icons.edit_outlined,
                    color: Color(0xFF2563EB),
                  ),
                ),
                IconButton(
                  tooltip: 'Delete configuration',
                  onPressed: () =>
                      widget.onDeleteConfiguration(item),
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // =========================================================
  // STATUS CHANGE
  // =========================================================

  Future<void> _handleStatusChanged(
      AdminConfiguration item,
      String newStatus,
      ) async {
    final currentStatus =
    _effectiveStatus(item);

    if (currentStatus == newStatus) {
      return;
    }

    final confirmed =
    await confirmAdminStatusChange(
      context,
      configuration: item,
      newStatus: newStatus,
    );

    if (!confirmed || !mounted) {
      return;
    }

    final now = DateTime.now();

    setState(() {
      _localStatuses[item.id] = newStatus;

      // Timer restarts from 0 on every status change,
      // and stops at Done.
      if (AdminWorkflowStatus.hasLiveTimer(newStatus)) {
        _localStatusStartedAt[item.id] = now;
      } else {
        _localStatusStartedAt.remove(item.id);
      }
    });

    widget.onStatusChanged(
      item,
      newStatus,
    );
  }

  String _effectiveStatus(
      AdminConfiguration item,
      ) {
    return _localStatuses[item.id] ??
        item.adminWorkflowStatus ??
        'requested';
  }

  DateTime? _effectiveStatusStartDate(
      AdminConfiguration item,
      String status,
      ) {
    final localStatus =
    _localStatuses[item.id];

    if (localStatus == status) {
      final localStart =
      _localStatusStartedAt[item.id];

      if (localStart != null) {
        return localStart;
      }
    }

    return _serverStatusStartDate(
      item,
      status,
    );
  }

  DateTime? _serverStatusStartDate(
      AdminConfiguration item,
      String status,
      ) {
    if (status == 'done') {
      return null;
    }

    // Current-status timer must always start from the latest
    // genuine admin workflow status transition.
    if (item.adminStatusChangedAt != null) {
      return item.adminStatusChangedAt;
    }

    // Backward compatibility for older configurations created
    // before adminStatusChangedAt was introduced.
    switch (status) {
      case 'requested':
        return item.adminRequestedAt;

      case 'pending':
        return item.adminStartedAt;

      default:
        return null;
    }
  }

  // =========================================================
  // ROW COLORS
  // =========================================================

  Color _rowColor(String status) {
    return AdminStatusStyle.row(
      status.toLowerCase(),
    );
  }

  Color _rowHoverColor(String status) {
    return AdminStatusStyle.hover(
      status.toLowerCase(),
    );
  }

  // =========================================================
  // CONFIGURATION DATES
  // =========================================================

  Widget _configurationDatesCell(
      AdminConfiguration item,
      ) {
    Widget line(
        String label,
        DateTime? value, {
          bool highlight = false,
        }) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              '$label:',
              textAlign: TextAlign.right,
              maxLines: 1,
              style: TextStyle(
                fontSize: 12,
                fontWeight:
                highlight ? FontWeight.w700 : FontWeight.w500,
                color: highlight
                    ? const Color(0xFF15803D)
                    : const Color(0xFF64748B),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              _date(value),
              textAlign: TextAlign.left,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                fontWeight:
                highlight ? FontWeight.w700 : FontWeight.w500,
                color: highlight
                    ? const Color(0xFF15803D)
                    : const Color(0xFF0F172A),
              ),
            ),
          ),
        ],
      );
    }

    final isDone =
        _effectiveStatus(item) == 'done';

    return SizedBox(
      width: 320,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            line(
              'Created',
              item.createdAt,
            ),
            const SizedBox(height: 4),
            line(
              'Updated',
              _hasDistinctUpdate(item)
                  ? item.updatedAt
                  : null,
            ),
            const SizedBox(height: 4),
            line(
              'Submitted',
              item.submittedAt,
            ),
            if (isDone &&
                item.adminCompletedAt != null) ...[
              const SizedBox(height: 4),
              line(
                'Completed',
                item.adminCompletedAt,
                highlight: true,
              ),
            ],
          ],
        ),
      ),
    );
  }

  // =========================================================
  // USER CELL
  // =========================================================

  Widget _configurationUserCell(
      AdminConfiguration item,
      ) {
    AdminUser? matchedUser;

    for (final user in widget.users) {
      if (user.userID == item.userID) {
        matchedUser = user;
        break;
      }
    }

    final createdBy = item.createdBy;

    final matchedFirstName =
        matchedUser?.firstName.trim() ?? '';

    final matchedLastName =
        matchedUser?.lastName.trim() ?? '';

    final firstName =
    matchedFirstName.isNotEmpty
        ? matchedFirstName
        : createdBy?['firstName']
        ?.toString()
        .trim() ??
        '';

    final lastName =
    matchedLastName.isNotEmpty
        ? matchedLastName
        : createdBy?['lastName']
        ?.toString()
        .trim() ??
        '';

    final matchedUsername =
        matchedUser?.username.trim() ?? '';

    final username =
    matchedUsername.isNotEmpty
        ? matchedUsername
        : createdBy?['username']
        ?.toString()
        .trim() ??
        '—';

    final matchedEmail =
        matchedUser?.email.trim() ?? '';

    final email =
    matchedEmail.isNotEmpty
        ? matchedEmail
        : '—';

    final fullName =
    '$firstName $lastName'.trim();

    final user = matchedUser;

    return SizedBox(
      width: 190,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment:
          MainAxisAlignment.center,
          crossAxisAlignment:
          CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment:
              MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    fullName.isNotEmpty
                        ? fullName
                        : username,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                if (user != null) ...[
                  const SizedBox(width: 4),
                  IconButton(
                    tooltip: 'View user details',
                    onPressed: () =>
                        widget.onViewUser(user),
                    visualDensity:
                    VisualDensity.compact,
                    padding: EdgeInsets.zero,
                    constraints:
                    const BoxConstraints(
                      minWidth: 28,
                      minHeight: 28,
                    ),
                    icon: const Icon(
                      Icons.visibility_outlined,
                      size: 17,
                    ),
                  ),
                ],
              ],
            ),
            Text(
              username,
              maxLines: 1,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF475569),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              email,
              maxLines: 1,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF64748B),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // LIVE STATUS AGE
  // =========================================================

  Widget _adminStatusAge(
      AdminConfiguration configuration,
      String status,
      ) {
    if (status == 'done') {
      return const SizedBox.shrink();
    }

    final startDate =
    _effectiveStatusStartDate(
      configuration,
      status,
    );

    if (startDate == null) {
      return const SizedBox.shrink();
    }

    if (!AdminWorkflowStatus.values.contains(status)) {
      return const SizedBox.shrink();
    }

    final color =
    AdminStatusStyle.text(status);

    final backgroundColor =
    AdminStatusStyle.row(status);

    var duration =
    DateTime.now().difference(
      startDate.toLocal(),
    );

    if (duration.isNegative) {
      duration = Duration.zero;
    }

    final durationText =
    _formatRunningDuration(duration);

    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 3,
        ),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius:
          BorderRadius.circular(12),
          border: Border.all(
            color: color.withOpacity(.25),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 5),
            Text(
              durationText,
              style: TextStyle(
                color: color,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatRunningDuration(
      Duration duration,
      ) {
    if (duration.inHours < 1) {
      return '${duration.inMinutes}m';
    }

    if (duration.inDays < 1) {
      final hours = duration.inHours;

      final minutes =
      duration.inMinutes.remainder(60);

      return '${hours}h ${minutes}m';
    }

    final days = duration.inDays;

    final hours =
    duration.inHours.remainder(24);

    if (hours == 0) {
      return '${days}d';
    }

    return '${days}d ${hours}h';
  }

  // =========================================================
  // TABLE CONTAINER
  //
  // NEW:
  // - Max vertical height = 520
  // - Vertical scrollbar always visible
  // - Vertical scrollbar draggable
  // - Thin scrollbar
  // - Horizontal scrolling preserved
  // =========================================================

  Widget _tableContainer(
      BuildContext context, {
        required bool empty,
        required String emptyText,
        required DataTable table,
      }) {
    if (empty) {
      return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
          BorderRadius.circular(14),
          border: Border.all(
            color:
            const Color(0xFFE2E8F0),
          ),
        ),
        child: Padding(
          padding:
          const EdgeInsets.all(48),
          child: Center(
            child: Text(emptyText),
          ),
        ),
      );
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
        BorderRadius.circular(14),
        border: Border.all(
          color:
          const Color(0xFFE2E8F0),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: LayoutBuilder(
        builder: (
            context,
            constraints,
            ) {
          return ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: (MediaQuery.sizeOf(context).height - 250).clamp(300.0, double.infinity),
            ),
            child: Scrollbar(
              controller:
              _verticalScrollController,

              // Always show vertical scrollbar.
              thumbVisibility: true,

              // Show scrollbar track as well.
              trackVisibility: true,

              // Allow mouse drag.
              interactive: true,

              // Small / clean scrollbar.
              thickness: 8,

              radius:
              const Radius.circular(8),

              child: SingleChildScrollView(
                controller:
                _verticalScrollController,
                scrollDirection:
                Axis.vertical,
                primary: false,
                child: Scrollbar(
                  controller:
                  _horizontalScrollController,

                  // Horizontal scrollbar is also
                  // always visible.
                  thumbVisibility: true,

                  trackVisibility: true,

                  interactive: true,

                  thickness: 8,

                  radius:
                  const Radius.circular(8),

                  notificationPredicate:
                      (notification) =>
                  notification.metrics.axis ==
                      Axis.horizontal,

                  child: SingleChildScrollView(
                    controller:
                    _horizontalScrollController,
                    scrollDirection:
                    Axis.horizontal,
                    primary: false,
                    child: ConstrainedBox(
                      constraints:
                      BoxConstraints(
                        minWidth:
                        constraints.maxWidth,
                      ),
                      child: table,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // =========================================================
  // HELPERS
  // =========================================================

  double _columnSpacing(
      BuildContext context,
      ) {
    return MediaQuery.sizeOf(context).width >=
        1200
        ? 24
        : 12;
  }

  String _date(DateTime? value) {
    if (value == null) {
      return '—';
    }

    final local = value.toLocal();

    String twoDigits(int number) =>
        number.toString().padLeft(2, '0');

    return '${twoDigits(local.month)}/'
        '${twoDigits(local.day)}/'
        '${local.year}';
  }

  bool _hasDistinctUpdate(
      AdminConfiguration configuration,
      ) {
    final created =
        configuration.createdAt;

    final updated =
        configuration.updatedAt;

    if (updated == null) {
      return false;
    }

    if (created == null) {
      return true;
    }

    return updated
        .difference(created)
        .abs()
        .inMinutes >=
        1;
  }
}