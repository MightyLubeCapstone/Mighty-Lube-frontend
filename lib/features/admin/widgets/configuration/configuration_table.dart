import 'package:flutter/material.dart';

import '../../models/admin_models.dart';

class ConfigurationTable extends StatelessWidget {
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
  });

  final List<AdminConfiguration> items;
  final List<AdminUser> users;

  final Set<String> updatingConfigurationIDs;
  final Set<String> deletingConfigurationIDs;

  final int Function(AdminConfiguration configuration)
  imageCountFor;

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

  static const List<String> _statuses = [
    'requested',
    'pending',
    'done',
  ];

  @override
  Widget build(BuildContext context) {
    return _tableContainer(
      context,
      empty: items.isEmpty,
      emptyText: 'No configurations found.',
      table: DataTable(
        columnSpacing: _columnSpacing(context),
        horizontalMargin: 12,
        headingRowHeight: 44,
        dataRowMinHeight: 92,
        dataRowMaxHeight: 112,
        dividerThickness: .65,
        columns: const [
          DataColumn(
            label: Text('Configuration'),
          ),
          DataColumn(
            label: Text('Product'),
          ),
          DataColumn(
            label: Text('QTY'),
            numeric: true,
          ),
          DataColumn(
            label: Text('Configuration dates'),
          ),
          DataColumn(
            label: Text('Admin status'),
          ),
          DataColumn(
            label: Text('User'),
          ),
          DataColumn(
            label: Text('Actions'),
          ),
        ],
        rows: items
            .map(
              (item) => _configurationRow(
            context,
            item,
          ),
        )
            .toList(),
      ),
    );
  }

  DataRow _configurationRow(
      BuildContext context,
      AdminConfiguration item,
      ) {
    final adminStatus =
        item.adminWorkflowStatus ?? 'requested';

    final imageCount = imageCountFor(item);

    return DataRow(
      cells: [
        // =====================================================
        // CONFIGURATION
        // =====================================================
        DataCell(
          _responsiveText(
            context,
            item.name,
            .13,
            120,
            210,
          ),
        ),

        // =====================================================
        // PRODUCT
        // =====================================================
        DataCell(
          SizedBox(
            width: 280,
            child: Text(
              item.productName.trim().isNotEmpty
                  ? item.productName
                  : item.productType,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                height: 1.25,
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
            child: Text(
              '${item.numRequested}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),

        // =====================================================
        // CONFIGURATION DATES
        // =====================================================
        DataCell(
          _configurationDatesCell(item),
        ),

        // =====================================================
        // ADMIN STATUS
        // =====================================================
        DataCell(
          updatingConfigurationIDs.contains(item.id)
              ? const SizedBox.square(
            dimension: 22,
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          )
              :
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: PopupMenuButton<String>(
                  initialValue: _statuses.contains(adminStatus)
                      ? adminStatus
                      : null,
                  padding: EdgeInsets.zero,

                  onSelected: (value) {
                    onStatusChanged(
                      item,
                      value,
                    );
                  },

                  itemBuilder: (context) {
                    return _statuses.map((value) {
                      return PopupMenuItem<String>(
                        value: value,
                        child: Text(
                          _titleCase(value),
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
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: const Color(0xFFE2E8F0),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _titleCase(adminStatus),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
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
              ),
              if (adminStatus != 'done') ...[
                const SizedBox(height: 2),
                _adminStatusAge(item),
              ],
            ],
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
          deletingConfigurationIDs.contains(item.id)
              ? const SizedBox.square(
            dimension: 22,
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          )
              : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                tooltip: 'View details',
                onPressed: () =>
                    onViewConfiguration(item),
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
                        onViewImages(item),
                    icon: const Icon(
                      Icons.photo_library_outlined,
                      size: 18,
                    ),
                    label: Text(
                      '$imageCount',
                    ),
                  ),
                ),
              IconButton(
                tooltip: 'Edit configuration',
                onPressed: () =>
                    onEditConfiguration(item),
                icon: const Icon(
                  Icons.edit_outlined,
                  color: Color(0xFF2563EB),
                ),
              ),
              IconButton(
                tooltip: 'Delete configuration',
                onPressed: () =>
                    onDeleteConfiguration(item),
                icon: const Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ],
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
      return Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 2,
        ),
        child: Row(
          children: [
            SizedBox(
              width: 95,
              child: Text(
                '$label:',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: highlight
                      ? FontWeight.w700
                      : FontWeight.w500,
                  color: highlight
                      ? const Color(0xFF15803D)
                      : const Color(0xFF64748B),
                ),
              ),
            ),

            Expanded(
              child: Text(
                _date(value),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: highlight
                      ? FontWeight.w700
                      : FontWeight.w500,
                  color: highlight
                      ? const Color(0xFF15803D)
                      : const Color(0xFF0F172A),
                ),
              ),
            ),
          ],
        ),
      );
    }

    final isDone =
        item.adminWorkflowStatus == 'done';

    return SizedBox(
      width: 320,
      child: Column(
        mainAxisAlignment:
        MainAxisAlignment.center,
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          line(
            'Created',
            item.createdAt,
          ),

          line(
            'Updated',
            _hasDistinctUpdate(item)
                ? item.updatedAt
                : null,
          ),

          line(
            'Submitted',
            item.submittedAt,
          ),

          // Only show after admin workflow is DONE.
          if (isDone &&
              item.adminCompletedAt != null)
            line(
              'Completed',
              item.adminCompletedAt,
              highlight: true,
            ),
        ],
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

    for (final user in users) {
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

    final email = matchedEmail.isNotEmpty
        ? matchedEmail
        : '—';

    final fullName =
    '$firstName $lastName'.trim();

    final user = matchedUser;

    return SizedBox(
      width: 190,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment:
        MainAxisAlignment.center,
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  fullName.isNotEmpty
                      ? fullName
                      : username,
                  maxLines: 1,
                  overflow:
                  TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight:
                    FontWeight.w700,
                  ),
                ),
              ),
              if (user != null)
                IconButton(
                  tooltip:
                  'View user details',
                  onPressed: () =>
                      onViewUser(user),
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
          ),
          Text(
            username,
            maxLines: 1,
            overflow:
            TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF475569),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            email,
            maxLines: 1,
            overflow:
            TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // ADMIN STATUS AGE
  // =========================================================

  Widget _adminStatusAge(AdminConfiguration configuration,) {
    final status = configuration.adminWorkflowStatus ?? 'requested';

    DateTime? startDate;
    Color color;
    Color backgroundColor;

    switch (status) {
      case 'requested':
        startDate = configuration.adminRequestedAt;
        color = const Color(0xFFD97706);
        backgroundColor = const Color(0xFFFFF7ED);
        break;

      case 'pending':
        startDate = configuration.adminStartedAt;
        color = const Color(0xFFDC2626);
        backgroundColor = const Color(0xFFFEF2F2);
        break;

      case 'done':
        return const SizedBox.shrink();

      default:
        return const SizedBox.shrink();
    }

    if (startDate == null) {
      return const SizedBox.shrink();
    }

    final duration = DateTime.now().difference(
      startDate.toLocal(),
    );

    String durationText;

    if (duration.inDays >= 1) {
      final days = duration.inDays;
      final hours = duration.inHours.remainder(24);

      durationText = hours > 0
          ? '${days}d ${hours}h'
          : '${days}d';
    } else if (duration.inHours >= 1) {
      durationText =
      '${duration.inHours}h '
          '${duration.inMinutes.remainder(60)}m';
    } else {
      durationText =
      '${duration.inMinutes.clamp(0, 59)}m';
    }

    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 3,
        ),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: color.withOpacity(.25),
          ),
        ),
        child: Text(
          durationText,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: color,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
  // =========================================================
  // TABLE CONTAINER
  // =========================================================

  Widget _tableContainer(
      BuildContext context, {
        required bool empty,
        required String emptyText,
        required DataTable table,
      }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
        BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
        ),
      ),
      child: empty
          ? Padding(
        padding:
        const EdgeInsets.all(48),
        child: Center(
          child: Text(emptyText),
        ),
      )
          : LayoutBuilder(
        builder: (
            context,
            constraints,
            ) {
          return SingleChildScrollView(
            scrollDirection:
            Axis.horizontal,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth:
                constraints.maxWidth,
              ),
              child: table,
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

  Widget _responsiveText(
      BuildContext context,
      String value,
      double fraction,
      double minimum,
      double maximum,
      ) {
    final width =
    (MediaQuery.sizeOf(context).width *
        fraction)
        .clamp(
      minimum,
      maximum,
    );

    return SizedBox(
      width: width,
      child: Tooltip(
        message: value,
        child: Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  String _titleCase(String value) {
    if (value.trim().isEmpty) {
      return value;
    }

    return value
        .split(' ')
        .where(
          (part) => part.isNotEmpty,
    )
        .map(
          (part) =>
      '${part[0].toUpperCase()}${part.substring(1).toLowerCase()}',
    )
        .join(' ');
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