import 'package:flutter/material.dart';

import '../../models/admin_models.dart';

class AdminFilterBar extends StatelessWidget {
  const AdminFilterBar({
    super.key,
    required this.filters,
    required this.onChanged,
    this.showStatusFilter = false,
    this.groupByStatus = false,
    this.onGroupByStatusChanged,
    this.people = const {},
    this.selectedUserID,
    this.onPersonChanged,
  });

  static const Map<String, String> _dateFields = {
    'createdAt': 'Created date',
    'updatedAt': 'Updated date',
  };

  static const Map<String, String> _dateFilters = {
    'all': 'All dates',
    'today': 'Today',
    'lastDay': 'Yesterday',
    'thisWeek': 'This week',
    'custom': 'Custom range',
  };

  static const Map<String, String> _statusFilters = {
    'all': 'All statuses',
    'requested': 'Requested',
    'pending': 'Pending',
    'done': 'Done',
  };

  final AdminConfigurationFilters filters;

  final ValueChanged<AdminConfigurationFilters> onChanged;

  final bool showStatusFilter;

  final bool groupByStatus;

  final ValueChanged<bool>? onGroupByStatusChanged;

  /// userID -> display name
  final Map<String, String> people;

  /// null means All People
  final String? selectedUserID;

  final ValueChanged<String?>? onPersonChanged;

  @override
  Widget build(BuildContext context) {
    final custom =
        filters.dateFilter == 'custom';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
        ),
      ),
      child: LayoutBuilder(
        builder: (
            context,
            constraints,
            ) {
          final compact =
              constraints.maxWidth < 720;

          final halfWidth =
              (constraints.maxWidth - 8) / 2;

          final showPeople =
              showStatusFilter &&
                  people.isNotEmpty;

          final controls = showStatusFilter
              ? (showPeople ? 6 : 5)
              : 3;

          final desktopGap =
              12.0 * (controls - 1);

          final remaining =
              constraints.maxWidth -
                  desktopGap -
                  44;

          final sortWidth = compact
              ? halfWidth
              : (remaining * .23).clamp(
            180.0,
            260.0,
          );

          final dateWidth = compact
              ? halfWidth
              : (remaining * .25).clamp(
            190.0,
            280.0,
          );

          final statusWidth = compact
              ? halfWidth
              : (remaining * .17).clamp(
            150.0,
            210.0,
          );

          final peopleWidth = compact
              ? halfWidth
              : (remaining * .20).clamp(
            170.0,
            240.0,
          );

          final groupWidth = compact
              ? (constraints.maxWidth -
              sortWidth -
              44 -
              16)
              .clamp(
            104.0,
            180.0,
          )
              : (constraints.maxWidth -
              desktopGap -
              44 -
              sortWidth -
              dateWidth -
              statusWidth -
              (showPeople
                  ? peopleWidth
                  : 0))
              .clamp(
            170.0,
            260.0,
          );

          final customDateWidth = compact
              ? halfWidth
              : (constraints.maxWidth -
              dateWidth -
              24)
              .clamp(
            180.0,
            220.0,
          );

          return Wrap(
            spacing: compact ? 8 : 12,
            runSpacing: compact ? 8 : 10,
            crossAxisAlignment:
            WrapCrossAlignment.center,
            children: [
              // =================================================
              // SORT BY
              // =================================================

              _dropdown(
                width: sortWidth,
                label:
                compact ? 'Sort' : 'Sort by',
                icon:
                compact ? null : Icons.sort,
                value: filters.sortBy,
                options: _dateFields,
                onChanged: (value) {
                  onChanged(
                    filters.copyWith(
                      sortBy: value,
                      dateField: value,
                    ),
                  );
                },
              ),

              // =================================================
              // SORT DIRECTION
              // =================================================

              _SortDirectionButton(
                compact: compact,
                sortOrder:
                filters.sortOrder,
                onPressed: () {
                  onChanged(
                    filters.copyWith(
                      sortOrder:
                      filters.sortOrder ==
                          'asc'
                          ? 'desc'
                          : 'asc',
                    ),
                  );
                },
              ),

              // =================================================
              // GROUP - COMPACT
              // =================================================

              if (showStatusFilter &&
                  compact)
                _GroupByStatusCheckbox(
                  width: groupWidth,
                  selected:
                  groupByStatus,
                  compact: compact,
                  onChanged:
                  onGroupByStatusChanged,
                ),

              // =================================================
              // DATE FILTER
              // =================================================

              _dropdown(
                width: dateWidth,
                label: compact
                    ? 'Date'
                    : 'Filter dates',
                icon: compact
                    ? null
                    : Icons
                    .filter_alt_outlined,
                value:
                filters.dateFilter,
                options: _dateFilters,
                onChanged: (value) {
                  if (value == 'custom') {
                    final today =
                    DateTime.now();

                    onChanged(
                      filters.copyWith(
                        dateField:
                        filters.sortBy,
                        dateFilter: value,
                        startDate:
                        filters.startDate ??
                            today,
                        endDate:
                        filters.endDate ??
                            today,
                      ),
                    );

                    return;
                  }

                  onChanged(
                    filters.copyWith(
                      dateField:
                      filters.sortBy,
                      dateFilter: value,
                      clearDates: true,
                    ),
                  );
                },
              ),

              // =================================================
              // STATUS + PEOPLE + GROUP
              // =================================================

              if (showStatusFilter) ...[
                // -------------------------
                // STATUS
                // -------------------------

                _dropdown(
                  width: statusWidth,
                  label: 'Status',
                  icon: compact
                      ? null
                      : Icons.flag_outlined,
                  value:
                  filters.adminWorkflowStatus ??
                      'all',
                  options:
                  _statusFilters,
                  onChanged: (value) {
                    onChanged(
                      filters.copyWith(
                        adminWorkflowStatus:
                        value,
                      ),
                    );
                  },
                ),

                // -------------------------
                // PEOPLE
                // -------------------------

                if (showPeople)
                  _dropdown(
                    width: peopleWidth,
                    label: 'People',
                    icon: compact
                        ? null
                        : Icons
                        .person_outline,
                    value:
                    selectedUserID ??
                        'all',
                    options: {
                      'all':
                      'All People',
                      ...people,
                    },
                    onChanged: (value) {
                      onPersonChanged?.call(
                        value == 'all'
                            ? null
                            : value,
                      );
                    },
                  ),

                // -------------------------
                // GROUP - DESKTOP
                // -------------------------

                if (!compact)
                  _GroupByStatusCheckbox(
                    width: groupWidth,
                    selected:
                    groupByStatus,
                    compact: compact,
                    onChanged:
                    onGroupByStatusChanged,
                  ),
              ],

              // =================================================
              // CUSTOM DATE RANGE
              // =================================================

              if (custom) ...[
                _dateButton(
                  context: context,
                  width:
                  customDateWidth,
                  label: 'Start',
                  icon: Icons
                      .date_range_outlined,
                  value:
                  filters.startDate,
                  onPicked: (date) {
                    onChanged(
                      filters.copyWith(
                        startDate: date,
                        endDate:
                        filters.endDate !=
                            null &&
                            filters
                                .endDate!
                                .isBefore(
                              date,
                            )
                            ? date
                            : filters
                            .endDate,
                      ),
                    );
                  },
                ),

                _dateButton(
                  context: context,
                  width:
                  customDateWidth,
                  label: 'End',
                  icon: Icons
                      .event_available_outlined,
                  value:
                  filters.endDate,
                  firstDate:
                  filters.startDate,
                  onPicked: (date) {
                    onChanged(
                      filters.copyWith(
                        endDate: date,
                      ),
                    );
                  },
                ),
              ],
            ],
          );
        },
      ),
    );
  }

  // =========================================================
  // DROPDOWN
  // =========================================================

  Widget _dropdown({
    required double width,
    required String label,
    required IconData? icon,
    required String value,
    required Map<String, String> options,
    required ValueChanged<String>
    onChanged,
  }) {
    // Safety:
    // DropdownButtonFormField requires the current value
    // to exist exactly once in the items.
    final safeValue =
    options.containsKey(value)
        ? value
        : options.keys.first;

    return SizedBox(
      width: width,
      child:
      DropdownButtonFormField<String>(
        key: ValueKey(
          '$label:$safeValue',
        ),
        initialValue: safeValue,
        isDense: true,
        isExpanded: true,
        decoration: _fieldDecoration(
          label,
          icon,
        ).copyWith(
          contentPadding:
          const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 10,
          ),
        ),
        items: options.entries
            .map(
              (entry) =>
              DropdownMenuItem<String>(
                value: entry.key,
                child: Text(
                  entry.value,
                  maxLines: 1,
                  overflow:
                  TextOverflow.ellipsis,
                ),
              ),
        )
            .toList(),
        onChanged: (value) {
          if (value != null) {
            onChanged(value);
          }
        },
      ),
    );
  }

  // =========================================================
  // DATE BUTTON
  // =========================================================

  Widget _dateButton({
    required BuildContext context,
    required double width,
    required String label,
    required IconData icon,
    required DateTime? value,
    required ValueChanged<DateTime>
    onPicked,
    DateTime? firstDate,
  }) {
    return SizedBox(
      width: width,
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          alignment:
          Alignment.centerLeft,
          padding:
          const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 12,
          ),
          shape:
          RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(
              4,
            ),
          ),
        ),
        onPressed: () async {
          final now =
          DateTime.now();

          final selected =
          await showDatePicker(
            context: context,
            initialDate:
            value ??
                firstDate ??
                now,
            firstDate:
            firstDate ??
                DateTime(2020),
            lastDate:
            DateTime(
              now.year + 5,
            ),
          );

          if (selected != null) {
            onPicked(selected);
          }
        },
        icon: Icon(
          icon,
          size: 20,
        ),
        label: Text(
          value == null
              ? label
              : '$label ${_dateOnly(value)}',
          overflow:
          TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight:
            FontWeight.w700,
          ),
        ),
      ),
    );
  }

  // =========================================================
  // FIELD DECORATION
  // =========================================================

  InputDecoration _fieldDecoration(
      String label,
      IconData? icon,
      ) {
    return InputDecoration(
      labelText: label,
      prefixIcon:
      icon == null
          ? null
          : Icon(icon),
      border:
      const OutlineInputBorder(),
      filled: true,
      fillColor: Colors.white,
      isDense: true,
    );
  }

  // =========================================================
  // DATE FORMAT
  // =========================================================

  String _dateOnly(
      DateTime value,
      ) {
    String twoDigits(
        int number,
        ) {
      return number
          .toString()
          .padLeft(
        2,
        '0',
      );
    }

    return '${value.year}-'
        '${twoDigits(value.month)}-'
        '${twoDigits(value.day)}';
  }
}

// ===========================================================
// SORT DIRECTION BUTTON
// ===========================================================

class _SortDirectionButton
    extends StatelessWidget {
  const _SortDirectionButton({
    required this.compact,
    required this.sortOrder,
    required this.onPressed,
  });

  final bool compact;

  final String sortOrder;

  final VoidCallback onPressed;

  @override
  Widget build(
      BuildContext context,
      ) {
    final descending =
        sortOrder == 'desc';

    return Tooltip(
      message: descending
          ? 'Descending'
          : 'Ascending',
      child:
      IconButton.filledTonal(
        constraints:
        const BoxConstraints
            .tightFor(
          width: 44,
          height: 44,
        ),
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        icon: Icon(
          descending
              ? Icons.arrow_downward
              : Icons.arrow_upward,
          size:
          compact ? 20 : 24,
        ),
      ),
    );
  }
}

// ===========================================================
// GROUP BY STATUS
// ===========================================================

class _GroupByStatusCheckbox
    extends StatelessWidget {
  const _GroupByStatusCheckbox({
    required this.width,
    required this.selected,
    required this.compact,
    required this.onChanged,
  });

  final double width;

  final bool selected;

  final bool compact;

  final ValueChanged<bool>?
  onChanged;

  @override
  Widget build(
      BuildContext context,
      ) {
    final content = compact
        ? Row(
      mainAxisAlignment:
      MainAxisAlignment.center,
      children: [
        Icon(
          selected
              ? Icons.check_box
              : Icons
              .check_box_outline_blank,
          size: 18,
          color: selected
              ? const Color(
            0xFF2563EB,
          )
              : null,
        ),
        const SizedBox(
          width: 5,
        ),
        Flexible(
          child: Text(
            'Group',
            maxLines: 1,
            overflow:
            TextOverflow
                .ellipsis,
            style: TextStyle(
              fontWeight:
              FontWeight.w800,
              color: selected
                  ? const Color(
                0xFF2563EB,
              )
                  : null,
            ),
          ),
        ),
      ],
    )
        : Row(
      mainAxisSize:
      MainAxisSize.min,
      children: [
        Checkbox(
          value: selected,
          visualDensity:
          VisualDensity
              .compact,
          onChanged:
          onChanged == null
              ? null
              : (value) {
            onChanged!(
              value ??
                  false,
            );
          },
        ),
        const Text(
          'Group by status',
          style: TextStyle(
            fontWeight:
            FontWeight.w700,
          ),
        ),
      ],
    );

    return Tooltip(
      message: 'Group by status',
      child: InkWell(
        borderRadius:
        BorderRadius.circular(8),
        onTap: onChanged == null
            ? null
            : () {
          onChanged!(
            !selected,
          );
        },
        child: Container(
          width: width,
          constraints:
          const BoxConstraints(
            minHeight: 44,
          ),
          alignment:
          Alignment.center,
          padding: compact
              ? EdgeInsets.zero
              : const EdgeInsets.only(
            left: 8,
            right: 12,
          ),
          decoration:
          BoxDecoration(
            color: selected
                ? const Color(
              0xFFE8F1FF,
            )
                : const Color(
              0xFFF8FAFC,
            ),
            borderRadius:
            BorderRadius.circular(
              8,
            ),
            border: Border.all(
              color: selected
                  ? const Color(
                0xFF2563EB,
              )
                  : const Color(
                0xFFDCE4F0,
              ),
            ),
          ),
          child: content,
        ),
      ),
    );
  }
}