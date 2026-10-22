import 'package:flutter/material.dart';
import '../../models/admin_models.dart';
import '../common/admin_status_style.dart';

class ConfigurationCards extends StatelessWidget {
  const ConfigurationCards({
    super.key,
    required this.items,
    required this.updatingConfigurationIDs,
    required this.deletingConfigurationIDs,
    required this.onStatusChanged,
    required this.onView,
    required this.onEdit,
    required this.onDelete,
    required this.onViewProject,
    this.expandProjects = false,
  });

  final List<AdminConfiguration> items;

  // true: project cards start open (Group by status).
  final bool expandProjects;

  final Set<String> updatingConfigurationIDs;
  final Set<String> deletingConfigurationIDs;

  final void Function(
      AdminConfiguration configuration,
      String? status,
      ) onStatusChanged;

  final void Function(
      AdminConfiguration configuration,
      ) onView;

  final void Function(
      AdminConfiguration configuration,
      ) onEdit;

  final void Function(
      AdminConfiguration configuration,
      ) onDelete;

  final void Function(
      AdminProjectGroup project,
      ) onViewProject;

  static const List<String> _statuses =
      AdminWorkflowStatus.values;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const _AdminListCard(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 28,
          ),
          child: Center(
            child: Text(
              'No configurations found.',
            ),
          ),
        ),
      );
    }

    return Column(
      children: [
        for (final entry
        in groupConfigurationsByProject(items))
          if (entry is AdminProjectGroup)
            _ProjectCard(
              group: entry,
              initiallyExpanded: expandProjects,
              onViewProject: onViewProject,
              itemBuilder: (item) =>
                  _configurationCard(
                    item,
                    inProject: true,
                  ),
            )
          else
            _configurationCard(
              entry as AdminConfiguration,
            ),
      ],
    );
  }

  // =========================================================
  // CONFIGURATION CARD
  // =========================================================

  Widget _configurationCard(
      AdminConfiguration item, {
        bool inProject = false,
      }) {
    final adminStatus =
        item.adminWorkflowStatus ??
            AdminWorkflowStatus.requested;

    return _AdminListCard(
      margin: const EdgeInsets.only(
        bottom: 12,
      ),
      background: AdminStatusStyle.row(adminStatus),
      leftEdgeColor: inProject
          ? AdminStatusStyle.projectColor
          : null,
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          // RFQ number on top of each card.
          Row(
            children: [
              Text(
                item.rfqLabel ?? 'RFQ —',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF0F172A),
                ),
              ),
              const SizedBox(width: 8),
              if (!inProject)
                const AdminStandaloneTag(),
            ],
          ),

          const SizedBox(
            height: 10,
          ),

          Row(
            crossAxisAlignment:
            CrossAxisAlignment.center,
            children: [
              _ConfigurationAgeStack(
                configuration: item,
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Text(
                  item.name,
                  maxLines: 1,
                  overflow:
                  TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight:
                    FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              _StatusBadge(
                adminStatus,
              ),
            ],
          ),

          // Cards show the timer for Pending and
          // Awaiting Response only.
          if (adminStatus == AdminWorkflowStatus.pending ||
              adminStatus ==
                  AdminWorkflowStatus.awaitingResponse) ...[
            const SizedBox(
              height: 12,
            ),
            _PendingAgePanel(
              configuration: item,
              status: adminStatus,
            ),
          ],

          const SizedBox(
            height: 12,
          ),

          _configurationInfoGrid(
            item,
          ),

          const SizedBox(
            height: 12,
          ),

          _configurationStatusActionRow(
            item,
          ),
        ],
      ),
    );
  }

  // =========================================================
  // INFORMATION GRID
  // =========================================================

  Widget _configurationInfoGrid(AdminConfiguration item,) {
    return LayoutBuilder(
      builder: (context, constraints,) {
        const gap = 10.0;
        final width = (constraints.maxWidth - gap) / 2;

        final info = [
          _InfoTileData(
            Icons.inventory_2_outlined,
            'Product',
            item.productName.trim().isNotEmpty
                ? item.productName
                : item.productType.trim().isNotEmpty
                ? item.productType
                : '—',
          ),
          _InfoTileData(
            Icons.numbers_outlined,
            'Quantity',
            '${item.numRequested}',
          ),
          _InfoTileData(
            Icons.category_outlined,
            'Product type',
            item.productType.trim().isNotEmpty
                ? item.productType
                : '—',
          ),
          _InfoTileData(
            Icons.settings_suggest_outlined,
            'Configuration',
            _productConfigurationPreview(
              item,
            ),
          ),
        ];

        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: [
            for (final infoItem in info)
              SizedBox(
                width: width,
                child: _InfoTile(
                  item: infoItem,
                ),
              ),
          ],
        );
      },
    );
  }

  String _productConfigurationPreview(
      AdminConfiguration item,
      ) {
    final previews = <String>[];

    for (final entry
    in item.configurationData.entries) {
      if (entry.key == '_id') {
        continue;
      }

      if (_isNested(entry.value)) {
        continue;
      }

      final value =
          entry.value?.toString().trim() ?? '';

      if (value.isEmpty) {
        continue;
      }

      previews.add(
        '${_readableLabel(entry.key)}: $value',
      );

      if (previews.length == 2) {
        break;
      }
    }

    if (previews.isNotEmpty) {
      return previews.join(', ');
    }

    if (item.configurationData.isNotEmpty) {
      return '${item.configurationData.length} field(s)';
    }

    return 'No details';
  }

  // =========================================================
  // STATUS + ACTIONS
  // =========================================================

  Widget _configurationStatusActionRow(AdminConfiguration item,) {
    return Row(
      crossAxisAlignment:
      CrossAxisAlignment.center,
      children: [
        Expanded(
          child: _configurationStatusControl(item,),
        ),
        const SizedBox(width: 8,),
        _ConfigurationCardActions(
          isDeleting: deletingConfigurationIDs.contains(
            item.id,
          ),
          onView: () => onView(item),
          onEdit: () => onEdit(item),
          onDelete: () => onDelete(item),
        ),
      ],
    );
  }

  Widget _configurationStatusControl(AdminConfiguration item,) {
    final adminStatus = item.adminWorkflowStatus ?? 'requested';

    if (updatingConfigurationIDs.contains(item.id,)) {
      return const SizedBox(
        height: 48,
        child: Center(
          child: SizedBox.square(
            dimension: 22,
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          ),
        ),
      );
    }

    // Popup menu (not a dropdown field) so the shown value
    // only changes once the admin confirms and the server
    // accepts it.
    return Builder(
      builder: (context) {
        return PopupMenuButton<String>(
          initialValue:
          _statuses.contains(adminStatus) ? adminStatus : null,
          onSelected: (value) async {
            if (value == adminStatus) {
              return;
            }

            final confirmed =
            await confirmAdminStatusChange(
              context,
              configuration: item,
              newStatus: value,
            );

            if (confirmed) {
              onStatusChanged(item, value);
            }
          },
          itemBuilder: (context) => [
            for (final value in _statuses)
              PopupMenuItem<String>(
                value: value,
                child: Text(
                  AdminWorkflowStatus.label(value),
                ),
              ),
          ],
          child: InputDecorator(
            decoration: _fieldDecoration(
              'Admin status',
              Icons.pending_actions,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    AdminWorkflowStatus.label(adminStatus),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Icon(
                  Icons.arrow_drop_down,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // =========================================================
  // HELPERS
  // =========================================================

  bool _isNested(dynamic value) {
    return value is Map || value is List;
  }

  String _readableLabel(String key) {
    const overrides = {
      'cc5ChainSize': 'CC5 chain size',
      'appEnviroment':
      'Application environment',
      'numRequested':
      'Quantity requested',
    };

    if (overrides.containsKey(key)) {
      return overrides[key]!;
    }

    final spaced = key
        .replaceAllMapped(
      RegExp(
        r'([a-z0-9])([A-Z])',
      ),
          (match) =>
      '${match[1]} ${match[2]}',
    )
        .replaceAll(
      '_',
      ' ',
    )
        .trim();

    if (spaced.isEmpty) {
      return key;
    }

    return '${spaced[0].toUpperCase()}'
        '${spaced.substring(1)}';
  }

  InputDecoration _fieldDecoration(
      String label,
      IconData icon,
      ) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(
        icon,
        size: 19,
      ),
      border: OutlineInputBorder(
        borderRadius:
        BorderRadius.circular(8),
      ),
      contentPadding:
      const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 10,
      ),
      isDense: true,
      filled: true,
      fillColor: Colors.white,
    );
  }
}

// ===========================================================
// CONFIGURATION AGE
// ===========================================================

class _ConfigurationAgeStack
    extends StatelessWidget {
  const _ConfigurationAgeStack({
    required this.configuration,
  });

  final AdminConfiguration configuration;

  @override
  Widget build(BuildContext context) {
    final createdAge = _elapsedAge(
      configuration.createdAt,
    );

    final updatedAge = _elapsedAge(
      configuration.updatedAt,
    );

    if (createdAge == null) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      width: 112,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _AgePill(
            label:
            'Created $createdAge ago',
            color:
            const Color(0xFF1D4ED8),
            background:
            const Color(0xFFEFF6FF),
            border:
            const Color(0xFFBFDBFE),
          ),

          if (_hasDistinctUpdate(
            configuration,
          ) &&
              updatedAge != null) ...[
            const SizedBox(
              height: 3,
            ),
            _AgePill(
              label:
              'Update $updatedAge ago',
              color:
              const Color(0xFF047857),
              background:
              const Color(0xFFECFDF5),
              border:
              const Color(0xFFA7F3D0),
            ),
          ],
        ],
      ),
    );
  }
}

class _AgePill extends StatelessWidget {
  const _AgePill({
    required this.label,
    required this.color,
    required this.background,
    required this.border,
  });

  final String label;
  final Color color;
  final Color background;
  final Color border;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      padding:
      const EdgeInsets.symmetric(
        horizontal: 6,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius:
        BorderRadius.circular(999),
        border: Border.all(
          color: border,
        ),
      ),
      child: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

// ===========================================================
// PENDING AGE
// ===========================================================

class _PendingAgePanel
    extends StatelessWidget {
  const _PendingAgePanel({
    required this.configuration,
    required this.status,
  });

  final AdminConfiguration configuration;

  final String status;

  @override
  Widget build(BuildContext context) {
    final age =
    _statusAge(configuration);

    if (age == null) {
      return const SizedBox.shrink();
    }

    final color =
    AdminStatusStyle.text(status);

    return Container(
      width: double.infinity,
      padding:
      const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
        BorderRadius.circular(8),
        border: Border.all(
          color: color,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.timer_outlined,
            color: color,
            size: 28,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            age,
            style: TextStyle(
              fontSize: 28,
              fontWeight:
              FontWeight.w900,
              color: color,
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Text(
              AdminWorkflowStatus.label(status)
                  .toLowerCase(),
              style: TextStyle(
                color: color,
                fontWeight:
                FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================
// PROJECT CARD
//
// Purple header that opens to show the project's RFQ cards.
// ===========================================================

class _ProjectCard extends StatefulWidget {
  const _ProjectCard({
    required this.group,
    required this.onViewProject,
    required this.itemBuilder,
    this.initiallyExpanded = false,
  });

  final AdminProjectGroup group;

  final bool initiallyExpanded;

  final void Function(
      AdminProjectGroup project,
      ) onViewProject;

  final Widget Function(
      AdminConfiguration item,
      ) itemBuilder;

  @override
  State<_ProjectCard> createState() =>
      _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  late bool _expanded = widget.initiallyExpanded;

  @override
  void didUpdateWidget(
      covariant _ProjectCard oldWidget,
      ) {
    super.didUpdateWidget(oldWidget);

    // Group by status switched on/off.
    if (oldWidget.initiallyExpanded != widget.initiallyExpanded) {
      _expanded = widget.initiallyExpanded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final group = widget.group;
    final count = group.items.length;

    return Column(
      children: [
        _AdminListCard(
          margin: const EdgeInsets.only(
            bottom: 12,
          ),
          background: AdminStatusStyle.projectBackground,
          leftEdgeColor: AdminStatusStyle.projectColor,
          child: InkWell(
            onTap: () => setState(() {
              _expanded = !_expanded;
            }),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      _expanded
                          ? Icons.keyboard_arrow_down
                          : Icons.keyboard_arrow_right,
                      color: AdminStatusStyle.projectColor,
                    ),
                    const Icon(
                      Icons.folder_outlined,
                      color: AdminStatusStyle.projectColor,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        group.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AdminStatusStyle.projectColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    IconButton(
                      tooltip: 'View project',
                      onPressed: () =>
                          widget.onViewProject(group),
                      icon: const Icon(
                        Icons.visibility_outlined,
                        color: AdminStatusStyle.projectColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  '$count RFQ${count == 1 ? '' : 's'} • '
                      '${adminConfigurationUserName(group.items.first)}',
                  style: const TextStyle(
                    color: Color(0xFF5B21B6),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                AdminProjectStatusSummary(
                  group: group,
                  alignment: WrapAlignment.start,
                ),
              ],
            ),
          ),
        ),
        if (_expanded)
          Padding(
            padding: const EdgeInsets.only(
              left: 12,
            ),
            child: Column(
              children: [
                for (final item in group.items)
                  widget.itemBuilder(item),
              ],
            ),
          ),
      ],
    );
  }
}

// ===========================================================
// ACTIONS
// ===========================================================

class _ConfigurationCardActions
    extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _compactAction(
          tooltip: 'View details',
          icon: const Icon(
            Icons.visibility_outlined,
          ),
          onPressed: onView,
        ),
        _compactAction(
          tooltip: 'Edit configuration',
          icon: const Icon(
            Icons.edit_outlined,
          ),
          onPressed: onEdit,
        ),
        _compactAction(
          tooltip:
          'Delete configuration',
          icon: isDeleting
              ? const SizedBox.square(
            dimension: 14,
            child:
            CircularProgressIndicator(
              strokeWidth: 2,
            ),
          )
              : const Icon(
            Icons.delete_outline,
            color: Colors.red,
          ),
          onPressed:
          isDeleting ? null : onDelete,
        ),
      ],
    );
  }

  Widget _compactAction({
    required String tooltip,
    required Widget icon,
    required VoidCallback? onPressed,
  }) {
    return SizedBox.square(
      dimension: 30,
      child: IconButton.filledTonal(
        tooltip: tooltip,
        onPressed: onPressed,
        icon: icon,
        iconSize: 16,
        padding: EdgeInsets.zero,
        visualDensity:
        VisualDensity.compact,
        style: IconButton.styleFrom(
          tapTargetSize:
          MaterialTapTargetSize
              .shrinkWrap,
        ),
      ),
    );
  }
}

// ===========================================================
// INFO TILE
// ===========================================================

class _InfoTileData {
  const _InfoTileData(
      this.icon,
      this.label,
      this.value,
      );

  final IconData icon;
  final String label;
  final String value;
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({
    required this.item,
  });

  final _InfoTileData item;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
      const BoxConstraints(
        minHeight: 58,
      ),
      padding:
      const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color:
        const Color(0xFFF8FAFC),
        borderRadius:
        BorderRadius.circular(8),
        border: Border.all(
          color:
          const Color(0xFFE2E8F0),
        ),
      ),
      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Icon(
            item.icon,
            size: 16,
            color:
            const Color(0xFF64748B),
          ),
          const SizedBox(
            width: 6,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  item.label,
                  maxLines: 1,
                  overflow:
                  TextOverflow.ellipsis,
                  style:
                  const TextStyle(
                    color:
                    Color(0xFF64748B),
                    fontSize: 11,
                    fontWeight:
                    FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  item.value,
                  maxLines: 2,
                  overflow:
                  TextOverflow.ellipsis,
                  style:
                  const TextStyle(
                    fontWeight:
                    FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================
// STATUS BADGE
// ===========================================================

class _StatusBadge extends StatelessWidget {
  const _StatusBadge(
      this.status,
      );

  final String status;

  @override
  Widget build(BuildContext context) {
    final color =
    AdminStatusStyle.text(status);

    return Container(
      padding:
      const EdgeInsets.symmetric(
        horizontal: 7,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(.12),
        borderRadius:
        BorderRadius.circular(30),
      ),
      child: Text(
        AdminWorkflowStatus.label(status),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

// ===========================================================
// CARD CONTAINER
// ===========================================================

class _AdminListCard
    extends StatelessWidget {
  const _AdminListCard({
    required this.child,
    this.margin = EdgeInsets.zero,
    this.background = Colors.white,
    this.leftEdgeColor,
  });

  final Widget child;
  final EdgeInsetsGeometry margin;
  final Color background;

  // Purple edge marks RFQs that belong to a project.
  final Color? leftEdgeColor;

  @override
  Widget build(BuildContext context) {
    final edge = leftEdgeColor;

    return Container(
      width: double.infinity,
      margin: margin,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: background,
        borderRadius:
        BorderRadius.circular(14),
        border: Border.all(
          color:
          const Color(0xFFE2E8F0),
        ),
      ),
      child: Container(
        padding: EdgeInsets.fromLTRB(
          edge == null ? 16 : 12,
          16,
          16,
          16,
        ),
        decoration: edge == null
            ? null
            : BoxDecoration(
          border: Border(
            left: BorderSide(
              color: edge,
              width: 4,
            ),
          ),
        ),
        child: child,
      ),
    );
  }
}

// ===========================================================
// TIME HELPERS
// ===========================================================

// Time in the current status. Restarts on every status
// change (adminStatusChangedAt), same as the table timer.
String? _statusAge(
    AdminConfiguration configuration,
    ) {
  final start =
      configuration.adminStatusChangedAt ??
          (configuration.isPending
              ? configuration.adminStartedAt
              : configuration.adminRequestedAt);

  if (start == null) {
    return null;
  }

  return _elapsedAge(start);
}

String? _elapsedAge(
    DateTime? date,
    ) {
  if (date == null) {
    return null;
  }

  final duration =
  DateTime.now().difference(
    date.toLocal(),
  );

  if (duration.inDays >= 1) {
    return '${duration.inDays}d';
  }

  if (duration.inHours >= 1) {
    return '${duration.inHours}h';
  }

  final minutes =
  duration.inMinutes.clamp(
    0,
    59,
  );

  return '${minutes}m';
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
      .inSeconds >
      1;
}