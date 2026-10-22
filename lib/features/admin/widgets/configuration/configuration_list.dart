import 'package:flutter/material.dart';

import '../../models/admin_models.dart';
import '../common/admin_status_style.dart';
import 'configuration_cards.dart';
import 'configuration_table.dart';

// ===========================================================
// CONFIGURATION LIST
//
// Group by status off -> one table / card list.
//
// Group by status on  -> one tab per status:
//
// [Pending 3] [Awaiting Response 2] [Requested 5] [Done 12]
//
// Tabs come from AdminWorkflowStatus.groupedValues, so a new
// status gets its own tab without changes here.
// ===========================================================

class ConfigurationList extends StatefulWidget {
  const ConfigurationList({
    super.key,
    required this.items,
    required this.users,
    required this.compact,
    required this.groupByStatus,
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

  final bool compact;

  final bool groupByStatus;

  final Set<String> updatingConfigurationIDs;

  final Set<String> deletingConfigurationIDs;

  final int Function(
      AdminConfiguration configuration,
      ) imageCountFor;

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
  State<ConfigurationList> createState() =>
      _ConfigurationListState();
}

class _ConfigurationListState
    extends State<ConfigurationList> {
  // null = first tab that has RFQs.
  String? _selectedStatus;

  // Last RFQ that left the open tab after a status change.
  _MovedRfq? _moved;

  static String _statusOf(
      AdminConfiguration item,
      ) {
    return item.adminWorkflowStatus ??
        AdminWorkflowStatus.requested;
  }

  Map<String, List<AdminConfiguration>> _byStatus(
      List<AdminConfiguration> items,
      ) {
    return {
      for (final status in AdminWorkflowStatus.groupedValues)
        status: items
            .where((item) => _statusOf(item) == status)
            .toList(),
    };
  }

  String _currentStatus(
      Map<String, List<AdminConfiguration>> groups,
      ) {
    final selected = _selectedStatus;

    if (selected != null && groups.containsKey(selected)) {
      return selected;
    }

    for (final entry in groups.entries) {
      if (entry.value.isNotEmpty) {
        return entry.key;
      }
    }

    return groups.keys.first;
  }

  @override
  void didUpdateWidget(
      covariant ConfigurationList oldWidget,
      ) {
    super.didUpdateWidget(oldWidget);

    if (!widget.groupByStatus) {
      _selectedStatus = null;
      _moved = null;
      return;
    }

    // Just switched on: start from the first tab with RFQs.
    if (!oldWidget.groupByStatus) {
      _selectedStatus = null;
      _moved = null;
      return;
    }

    // An RFQ in the open tab got a new status: tell the admin
    // where it went, since it disappears from this tab.
    final openStatus = _currentStatus(
      _byStatus(oldWidget.items),
    );

    final oldStatuses = {
      for (final item in oldWidget.items)
        item.id: _statusOf(item),
    };

    for (final item in widget.items) {
      final before = oldStatuses[item.id];
      final now = _statusOf(item);

      if (before == openStatus && now != before) {
        // Keep the admin on the tab they were working in.
        _selectedStatus = openStatus;

        _moved = _MovedRfq(
          label: item.rfqLabel ?? item.productName,
          status: now,
        );

        break;
      }
    }
  }

  void _selectStatus(
      String status,
      ) {
    setState(() {
      _selectedStatus = status;
      _moved = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.groupByStatus) {
      return _buildList(widget.items);
    }

    final groups = _byStatus(widget.items);
    final current = _currentStatus(groups);
    final currentItems = groups[current]!;
    final moved = _moved;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _StatusTabs(
          groups: groups,
          selected: current,
          onSelected: _selectStatus,
        ),

        const SizedBox(
          height: 12,
        ),

        if (moved != null) ...[
          _MovedBanner(
            moved: moved,
            onView: () => _selectStatus(moved.status),
            onClose: () => setState(() => _moved = null),
          ),

          const SizedBox(
            height: 12,
          ),
        ],

        if (currentItems.isEmpty)
          _EmptyConfigurationCard(
            text:
            'No ${AdminWorkflowStatus.label(current)} RFQs.',
          )
        else
          _buildList(currentItems),
      ],
    );
  }

  // =========================================================
  // TABLE / CARDS
  // =========================================================

  Widget _buildList(
      List<AdminConfiguration> configurations,
      ) {
    if (widget.compact) {
      return ConfigurationCards(
        items: configurations,
        // Grouped: show project RFQs without an extra click.
        expandProjects: widget.groupByStatus,
        updatingConfigurationIDs:
        widget.updatingConfigurationIDs,
        deletingConfigurationIDs:
        widget.deletingConfigurationIDs,
        onStatusChanged:
        widget.onStatusChanged,
        onView:
        widget.onViewConfiguration,
        onEdit:
        widget.onEditConfiguration,
        onDelete:
        widget.onDeleteConfiguration,
        onViewProject:
        widget.onViewProject,
      );
    }

    return ConfigurationTable(
      items: configurations,
      expandProjectsByDefault: widget.groupByStatus,
      users: widget.users,
      updatingConfigurationIDs:
      widget.updatingConfigurationIDs,
      deletingConfigurationIDs:
      widget.deletingConfigurationIDs,
      imageCountFor:
      widget.imageCountFor,
      onStatusChanged:
      widget.onStatusChanged,
      onViewConfiguration:
      widget.onViewConfiguration,
      onViewImages:
      widget.onViewImages,
      onEditConfiguration:
      widget.onEditConfiguration,
      onDeleteConfiguration:
      widget.onDeleteConfiguration,
      onViewUser:
      widget.onViewUser,
      onViewProject:
      widget.onViewProject,
    );
  }
}

class _MovedRfq {
  const _MovedRfq({
    required this.label,
    required this.status,
  });

  final String label;

  final String status;
}

// ===========================================================
// STATUS TABS
//
// Wide screens: tabs share the full width.
// Phones: tabs keep their size and scroll sideways.
// ===========================================================

class _StatusTabs extends StatelessWidget {
  const _StatusTabs({
    required this.groups,
    required this.selected,
    required this.onSelected,
  });

  final Map<String, List<AdminConfiguration>> groups;

  final String selected;

  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final fill = constraints.maxWidth >= 720;

        final tabs = [
          for (final entry in groups.entries)
            _StatusTab(
              status: entry.key,
              count: entry.value.length,
              selected: entry.key == selected,
              onTap: () => onSelected(entry.key),
            ),
        ];

        if (fill) {
          return Row(
            children: [
              for (var i = 0; i < tabs.length; i++) ...[
                if (i > 0)
                  const SizedBox(
                    width: 10,
                  ),
                Expanded(
                  child: tabs[i],
                ),
              ],
            ],
          );
        }

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (var i = 0; i < tabs.length; i++) ...[
                if (i > 0)
                  const SizedBox(
                    width: 8,
                  ),
                tabs[i],
              ],
            ],
          ),
        );
      },
    );
  }
}

class _StatusTab extends StatelessWidget {
  const _StatusTab({
    required this.status,
    required this.count,
    required this.selected,
    required this.onTap,
  });

  final String status;

  final int count;

  final bool selected;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final empty = count == 0;

    final color = empty && !selected
        ? const Color(0xFF94A3B8)
        : AdminStatusStyle.text(status);

    final background = selected
        ? AdminStatusStyle.text(status)
        : empty
        ? const Color(0xFFF8FAFC)
        : AdminStatusStyle.row(status);

    final border = selected
        ? AdminStatusStyle.text(status)
        : empty
        ? const Color(0xFFE2E8F0)
        : AdminStatusStyle.border(status);

    final foreground = selected ? Colors.white : color;

    return Material(
      color: background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: border,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 11,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  AdminWorkflowStatus.label(status),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: foreground,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: selected
                      ? Colors.white.withValues(alpha: 0.25)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '$count',
                  style: TextStyle(
                    color: foreground,
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ===========================================================
// MOVED BANNER
//
// "RFQ-10021 moved to Awaiting Response   [View] [✕]"
// ===========================================================

class _MovedBanner extends StatelessWidget {
  const _MovedBanner({
    required this.moved,
    required this.onView,
    required this.onClose,
  });

  final _MovedRfq moved;

  final VoidCallback onView;

  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final color = AdminStatusStyle.text(moved.status);

    return Container(
      padding: const EdgeInsets.fromLTRB(14, 6, 6, 6),
      decoration: BoxDecoration(
        color: AdminStatusStyle.row(moved.status),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AdminStatusStyle.border(moved.status),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.swap_horiz,
            size: 20,
            color: color,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: moved.label,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const TextSpan(
                    text: ' moved to ',
                  ),
                  TextSpan(
                    text: AdminWorkflowStatus.label(moved.status),
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              style: const TextStyle(
                color: Color(0xFF0F172A),
              ),
            ),
          ),
          TextButton(
            onPressed: onView,
            style: TextButton.styleFrom(
              foregroundColor: color,
            ),
            child: const Text(
              'View',
              style: TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          IconButton(
            tooltip: 'Dismiss',
            onPressed: onClose,
            icon: const Icon(
              Icons.close,
              size: 18,
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================
// EMPTY CARD
// ===========================================================

class _EmptyConfigurationCard extends StatelessWidget {
  const _EmptyConfigurationCard({
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 28,
        ),
        child: Center(
          child: Text(text),
        ),
      ),
    );
  }
}
