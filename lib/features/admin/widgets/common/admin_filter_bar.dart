import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../models/admin_models.dart';

// ===========================================================
// ADMIN FILTER BAR
//
// Wide screens:
//
// [🔍] [Sort by] [↓] [Status] [Type] [Project] [People] [Date]
//      [Group by status] [Clear filters (2)]
//
// Tapping 🔍 swaps the row for the search box:
//
// [Search .......................................] [✕ Close]
//
// Phones:
//
// [Search ..........] [Filters (2)] [↓]
// (Status: Pending ✕) (Type: Projects ✕)
//
// "Filters" opens a bottom sheet with every option; changes
// apply together when the admin taps Apply.
//
// Users tab (showStatusFilter = false) only has sort + date.
// ===========================================================

class AdminFilterBar extends StatefulWidget {
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
    this.rfqType = 'all',
    this.onRfqTypeChanged,
    this.projects = const {},
    this.selectedProjectKey,
    this.onProjectChanged,
    this.searchText = '',
    this.onSearchChanged,
  });

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

  // =========================================================
  // RFQ / PROJECT FILTERS (configurations tab only)
  // =========================================================

  /// all / standalone / projects
  final String rfqType;

  final ValueChanged<String>? onRfqTypeChanged;

  /// project group key -> "P-10001 • Project name"
  final Map<String, String> projects;

  /// null means All Projects
  final String? selectedProjectKey;

  final ValueChanged<String?>? onProjectChanged;

  /// Matches RFQ #, P # and project name.
  final String searchText;

  final ValueChanged<String>? onSearchChanged;

  @override
  State<AdminFilterBar> createState() =>
      _AdminFilterBarState();
}

class _AdminFilterBarState
    extends State<AdminFilterBar> {
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

  // Built from AdminWorkflowStatus so new statuses show up here.
  static final Map<String, String> _statusFilters = {
    'all': 'All statuses',
    for (final status in AdminWorkflowStatus.values)
      status: AdminWorkflowStatus.label(status),
  };

  static const Map<String, String> _rfqTypes = {
    'all': 'All RFQs',
    'standalone': 'Standalone only',
    'projects': 'Projects only',
  };

  static const Color _border = Color(0xFFE2E8F0);
  static const Color _accent = Color(0xFF2563EB);

  // Below this width the phone layout is used.
  static const double _phoneWidth = 640;

  static const double _gap = 10;

  late final TextEditingController _searchController =
  TextEditingController(
    text: widget.searchText,
  );

  final FocusNode _searchFocus = FocusNode();

  // Wide layout only: search box expanded over the filters.
  bool _searchOpen = false;

  AdminConfigurationFilters get filters => widget.filters;

  bool get _showPeople =>
      widget.showStatusFilter && widget.people.isNotEmpty;

  @override
  void didUpdateWidget(
      covariant AdminFilterBar oldWidget,
      ) {
    super.didUpdateWidget(oldWidget);

    // Parent cleared or changed the search (e.g. Clear filters).
    if (widget.searchText != _searchController.text) {
      _searchController.text = widget.searchText;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocus.dispose();
    super.dispose();
  }

  // =========================================================
  // FILTER HELPERS
  // =========================================================

  static AdminConfigurationFilters _withDateFilter(
      AdminConfigurationFilters filters,
      String value,
      ) {
    if (value == 'custom') {
      final today = DateTime.now();

      return filters.copyWith(
        dateField: filters.sortBy,
        dateFilter: value,
        startDate: filters.startDate ?? today,
        endDate: filters.endDate ?? today,
      );
    }

    return filters.copyWith(
      dateField: filters.sortBy,
      dateFilter: value,
      clearDates: true,
    );
  }

  static AdminConfigurationFilters _withStartDate(
      AdminConfigurationFilters filters,
      DateTime date,
      ) {
    return filters.copyWith(
      startDate: date,
      endDate: filters.endDate != null &&
          filters.endDate!.isBefore(date)
          ? date
          : filters.endDate,
    );
  }

  static bool _sameFilters(
      AdminConfigurationFilters a,
      AdminConfigurationFilters b,
      ) {
    return a.sortBy == b.sortBy &&
        a.sortOrder == b.sortOrder &&
        a.dateField == b.dateField &&
        a.dateFilter == b.dateFilter &&
        a.startDate == b.startDate &&
        a.endDate == b.endDate &&
        a.adminWorkflowStatus == b.adminWorkflowStatus;
  }

  bool get _statusActive =>
      widget.showStatusFilter &&
          (filters.adminWorkflowStatus ?? 'all') != 'all';

  bool get _dateActive => filters.dateFilter != 'all';

  bool get _personActive =>
      _showPeople && widget.selectedUserID != null;

  bool get _typeActive =>
      widget.showStatusFilter && widget.rfqType != 'all';

  bool get _projectActive =>
      widget.showStatusFilter && widget.selectedProjectKey != null;

  int get _activeCount => [
    _statusActive,
    _dateActive,
    _personActive,
    _typeActive,
    _projectActive,
  ].where((active) => active).length;

  String _dateChipText() {
    if (filters.dateFilter != 'custom') {
      return _dateFilters[filters.dateFilter] ??
          filters.dateFilter;
    }

    final start = filters.startDate == null
        ? '…'
        : _dateOnly(filters.startDate!);

    final end = filters.endDate == null
        ? '…'
        : _dateOnly(filters.endDate!);

    return '$start → $end';
  }

  void _toggleSortOrder() {
    widget.onChanged(
      filters.copyWith(
        sortOrder: filters.sortOrder == 'asc' ? 'desc' : 'asc',
      ),
    );
  }

  // Resets filters only. Sort, grouping and search stay.
  void _clearFilters() {
    if (_statusActive || _dateActive) {
      widget.onChanged(
        filters.copyWith(
          adminWorkflowStatus:
          widget.showStatusFilter ? 'all' : null,
          dateFilter: 'all',
          clearDates: true,
        ),
      );
    }

    if (_personActive) {
      widget.onPersonChanged?.call(null);
    }

    if (_typeActive) {
      widget.onRfqTypeChanged?.call('all');
    }

    if (_projectActive) {
      widget.onProjectChanged?.call(null);
    }
  }

  // =========================================================
  // BUILD
  // =========================================================

  @override
  Widget build(
      BuildContext context,
      ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _border,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D0F172A),
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (
            context,
            constraints,
            ) {
          final width = constraints.maxWidth;

          if (!widget.showStatusFilter) {
            return _buildSortAndDate(width);
          }

          return width < _phoneWidth
              ? _buildPhone()
              : _buildWide(width);
        },
      ),
    );
  }

  // =========================================================
  // USERS TAB: SORT + DATE
  // =========================================================

  Widget _buildSortAndDate(
      double width,
      ) {
    final phone = width < _phoneWidth;

    // Phone: two fields per line next to the sort button.
    final fieldWidth = phone
        ? (width - 44 - _gap * 2 - 1) / 2
        : 220.0;

    return Wrap(
      spacing: _gap,
      runSpacing: _gap,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        _sortDropdown(
          width: fieldWidth,
          filters: filters,
          onChanged: widget.onChanged,
        ),
        _SortDirectionButton(
          compact: phone,
          sortOrder: filters.sortOrder,
          onPressed: _toggleSortOrder,
        ),
        _dateDropdown(
          width: fieldWidth,
          filters: filters,
          onChanged: widget.onChanged,
        ),
        if (filters.dateFilter == 'custom')
          ..._customDateButtons(
            width: phone ? (width - _gap) / 2 : 200,
            filters: filters,
            onChanged: widget.onChanged,
          ),
        if (_dateActive)
          _clearButton(),
      ],
    );
  }

  // =========================================================
  // WIDE LAYOUT (tablet / desktop)
  // =========================================================

  // Search open: the search box takes the whole row and the
  // close button sits at the right end.
  //
  // Search closed: a search icon followed by every filter on
  // one row. Anything that does not fit wraps to the next line.
  Widget _buildWide(
      double width,
      ) {
    if (_searchOpen) {
      return Row(
        children: [
          Expanded(
            child: CallbackShortcuts(
              bindings: {
                const SingleActivator(LogicalKeyboardKey.escape):
                _closeSearch,
              },
              child: _searchField(
                focusNode: _searchFocus,
              ),
            ),
          ),
          const SizedBox(width: _gap),
          SizedBox(
            height: 44,
            child: OutlinedButton.icon(
              onPressed: _closeSearch,
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF334155),
                side: const BorderSide(
                  color: _border,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: const Icon(
                Icons.close,
                size: 18,
              ),
              label: const Text(
                'Close',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      );
    }

    final active = _activeCount;

    final fullGroupLabel = width >= 1300;

    final groupWidth = fullGroupLabel ? 170.0 : 96.0;

    final custom = filters.dateFilter == 'custom';

    // Sort, Status, Type, Project, (People), Date, (Start, End).
    final fieldCount =
        (_showPeople ? 6 : 5) + (custom ? 2 : 0);

    // Search + sort direction + group + clear.
    final fixedWidth = _searchButtonWidth +
        44.0 +
        groupWidth +
        (active > 0 ? 150.0 : 0.0);

    final itemCount = 3 + fieldCount + (active > 0 ? 1 : 0);

    final spaceForFields =
        width - fixedWidth - _gap * (itemCount - 1);

    // Everything fits on one line: fields stretch equally so
    // the row is filled edge to edge.
    if (spaceForFields / fieldCount >= _minFieldWidth) {
      Widget field(Widget child) => Expanded(child: child);

      final children = <Widget>[
        _searchButton(),
        field(
          _sortDropdown(
            width: double.infinity,
            filters: filters,
            onChanged: widget.onChanged,
          ),
        ),
        _SortDirectionButton(
          compact: false,
          sortOrder: filters.sortOrder,
          onPressed: _toggleSortOrder,
        ),
        ..._filterFields(
          width: double.infinity,
        ).map(field),
        _GroupByStatusCheckbox(
          width: groupWidth,
          selected: widget.groupByStatus,
          compact: !fullGroupLabel,
          onChanged: widget.onGroupByStatusChanged,
        ),
        if (active > 0)
          _clearButton(
            count: active,
          ),
      ];

      return Row(
        children: [
          for (var i = 0; i < children.length; i++) ...[
            if (i > 0) const SizedBox(width: _gap),
            children[i],
          ],
        ],
      );
    }

    // Not enough room: fixed-width fields that wrap.
    final fieldWidth =
    (spaceForFields / fieldCount).clamp(_minFieldWidth, 220.0);

    return Wrap(
      spacing: _gap,
      runSpacing: _gap,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        _searchButton(),
        _sortDropdown(
          width: fieldWidth,
          filters: filters,
          onChanged: widget.onChanged,
        ),
        _SortDirectionButton(
          compact: false,
          sortOrder: filters.sortOrder,
          onPressed: _toggleSortOrder,
        ),
        ..._filterFields(
          width: fieldWidth,
        ),
        _GroupByStatusCheckbox(
          width: groupWidth,
          selected: widget.groupByStatus,
          compact: !fullGroupLabel,
          onChanged: widget.onGroupByStatusChanged,
        ),
        if (active > 0)
          _clearButton(
            count: active,
          ),
      ],
    );
  }

  static const double _minFieldWidth = 130;

  static const double _searchButtonWidth = 130;

  // Status, Type, Project, People, Date and the custom range.
  List<Widget> _filterFields({
    required double width,
  }) {
    return [
      _statusDropdown(
        width: width,
        filters: filters,
        onChanged: widget.onChanged,
        enabled: !widget.groupByStatus,
      ),
      _typeDropdown(
        width: width,
        value: widget.rfqType,
        onChanged: (value) =>
            widget.onRfqTypeChanged?.call(value),
      ),
      _projectDropdown(
        width: width,
        value: widget.selectedProjectKey,
        onChanged: (value) =>
            widget.onProjectChanged?.call(value),
      ),
      if (_showPeople)
        _peopleDropdown(
          width: width,
          value: widget.selectedUserID,
          onChanged: (value) =>
              widget.onPersonChanged?.call(value),
        ),
      _dateDropdown(
        width: width,
        filters: filters,
        onChanged: widget.onChanged,
      ),
      if (filters.dateFilter == 'custom')
        ..._customDateButtons(
          width: width,
          filters: filters,
          onChanged: widget.onChanged,
        ),
    ];
  }

  // Looks like a small search box so it reads as "search",
  // not as another action button. While a search is applied
  // it turns blue and shows the text being searched.
  Widget _searchButton() {
    final text = _searchController.text;
    final searching = text.isNotEmpty;

    return Tooltip(
      message: searching
          ? 'Search: $text'
          : 'Search RFQ #, P # or project name',
      child: Material(
        color: searching
            ? const Color(0xFFE8F1FF)
            : const Color(0xFFF8FAFC),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
          side: BorderSide(
            color: searching ? _accent : _border,
          ),
        ),
        child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          onTap: _openSearch,
          child: SizedBox(
            width: _searchButtonWidth,
            height: 44,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    size: 20,
                    color: searching
                        ? _accent
                        : const Color(0xFF64748B),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      searching ? text : 'Search',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: searching
                            ? _accent
                            : const Color(0xFF64748B),
                        fontWeight: searching
                            ? FontWeight.w700
                            : FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _openSearch() {
    setState(() => _searchOpen = true);

    // The field is built in the next frame.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _searchFocus.requestFocus();
      }
    });
  }

  // Keeps the typed text; results stay filtered.
  void _closeSearch() {
    _searchFocus.unfocus();
    setState(() => _searchOpen = false);
  }

  // =========================================================
  // PHONE LAYOUT
  // =========================================================

  Widget _buildPhone() {
    final active = _activeCount;

    final chips = <Widget>[
      if (_statusActive)
        _activeChip(
          'Status: ${_statusFilters[filters.adminWorkflowStatus] ?? filters.adminWorkflowStatus}',
              () => widget.onChanged(
            filters.copyWith(
              adminWorkflowStatus: 'all',
            ),
          ),
        ),
      if (_typeActive)
        _activeChip(
          'Type: ${_rfqTypes[widget.rfqType] ?? widget.rfqType}',
              () => widget.onRfqTypeChanged?.call('all'),
        ),
      if (_projectActive)
        _activeChip(
          'Project: ${widget.projects[widget.selectedProjectKey] ?? widget.selectedProjectKey}',
              () => widget.onProjectChanged?.call(null),
        ),
      if (_personActive)
        _activeChip(
          'Person: ${widget.people[widget.selectedUserID] ?? widget.selectedUserID}',
              () => widget.onPersonChanged?.call(null),
        ),
      if (_dateActive)
        _activeChip(
          'Date: ${_dateChipText()}',
              () => widget.onChanged(
            filters.copyWith(
              dateFilter: 'all',
              clearDates: true,
            ),
          ),
        ),
      if (widget.groupByStatus)
        _activeChip(
          'Grouped by status',
              () => widget.onGroupByStatusChanged?.call(false),
        ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: _searchField(
                hint: 'Search RFQ, project...',
              ),
            ),
            const SizedBox(width: 8),
            Badge(
              isLabelVisible: active > 0,
              label: Text('$active'),
              backgroundColor: _accent,
              child: SizedBox(
                height: 44,
                child: OutlinedButton.icon(
                  onPressed: _openFilterSheet,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                    ),
                    side: BorderSide(
                      color: active > 0 ? _accent : _border,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  icon: const Icon(
                    Icons.tune,
                    size: 18,
                  ),
                  label: const Text(
                    'Filters',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            _SortDirectionButton(
              compact: true,
              sortOrder: filters.sortOrder,
              onPressed: _toggleSortOrder,
            ),
          ],
        ),
        if (chips.isNotEmpty) ...[
          const SizedBox(height: 10),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: chips,
          ),
        ],
      ],
    );
  }

  Widget _activeChip(
      String label,
      VoidCallback onRemove,
      ) {
    return InputChip(
      label: Text(
        label,
        overflow: TextOverflow.ellipsis,
      ),
      labelStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: Color(0xFF1E3A8A),
      ),
      backgroundColor: const Color(0xFFE8F1FF),
      side: const BorderSide(
        color: Color(0xFFBFD4FE),
      ),
      visualDensity: VisualDensity.compact,
      onDeleted: onRemove,
      deleteIconColor: const Color(0xFF1E3A8A),
    );
  }

  // =========================================================
  // PHONE FILTER SHEET
  //
  // Works on a draft so the list reloads once, on Apply.
  // =========================================================

  Future<void> _openFilterSheet() async {
    var draft = filters;
    var draftPerson = widget.selectedUserID;
    var draftType = widget.rfqType;
    var draftProject = widget.selectedProjectKey;
    var draftGroup = widget.groupByStatus;

    final applied = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: Colors.white,
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (sheetContext, setSheetState) {
            final sheetWidth =
                MediaQuery.sizeOf(sheetContext).width - 40;

            return Padding(
              padding: EdgeInsets.fromLTRB(
                20,
                0,
                20,
                20 + MediaQuery.viewInsetsOf(sheetContext).bottom,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Sort & filter',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _sortDropdown(
                      width: sheetWidth,
                      filters: draft,
                      onChanged: (value) =>
                          setSheetState(() => draft = value),
                    ),
                    const SizedBox(height: 12),
                    _GroupByStatusCheckbox(
                      width: sheetWidth,
                      selected: draftGroup,
                      compact: false,
                      onChanged: (value) => setSheetState(() {
                        draftGroup = value;

                        // Status tabs replace the Status filter.
                        if (value) {
                          draft = draft.copyWith(
                            adminWorkflowStatus: 'all',
                          );
                        }
                      }),
                    ),
                    const SizedBox(height: 20),
                    _statusDropdown(
                      width: sheetWidth,
                      filters: draft,
                      onChanged: (value) =>
                          setSheetState(() => draft = value),
                      enabled: !draftGroup,
                    ),
                    const SizedBox(height: 12),
                    _typeDropdown(
                      width: sheetWidth,
                      value: draftType,
                      onChanged: (value) =>
                          setSheetState(() => draftType = value),
                    ),
                    const SizedBox(height: 12),
                    _projectDropdown(
                      width: sheetWidth,
                      value: draftProject,
                      onChanged: (value) =>
                          setSheetState(() => draftProject = value),
                    ),
                    if (_showPeople) ...[
                      const SizedBox(height: 12),
                      _peopleDropdown(
                        width: sheetWidth,
                        value: draftPerson,
                        onChanged: (value) =>
                            setSheetState(() => draftPerson = value),
                      ),
                    ],
                    const SizedBox(height: 12),
                    _dateDropdown(
                      width: sheetWidth,
                      filters: draft,
                      onChanged: (value) =>
                          setSheetState(() => draft = value),
                    ),
                    if (draft.dateFilter == 'custom') ...[
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: _gap,
                        runSpacing: _gap,
                        children: _customDateButtons(
                          width: (sheetWidth - _gap) / 2,
                          filters: draft,
                          onChanged: (value) =>
                              setSheetState(() => draft = value),
                        ),
                      ),
                    ],
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              setSheetState(() {
                                draft = draft.copyWith(
                                  adminWorkflowStatus: 'all',
                                  dateFilter: 'all',
                                  clearDates: true,
                                );
                                draftPerson = null;
                                draftType = 'all';
                                draftProject = null;
                              });
                            },
                            style: OutlinedButton.styleFrom(
                              minimumSize: const Size.fromHeight(46),
                            ),
                            child: const Text('Clear all'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: FilledButton(
                            onPressed: () =>
                                Navigator.of(sheetContext).pop(true),
                            style: FilledButton.styleFrom(
                              minimumSize: const Size.fromHeight(46),
                              backgroundColor: const Color(0xFF17223B),
                            ),
                            child: const Text('Apply'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );

    if (applied != true || !mounted) {
      return;
    }

    if (!_sameFilters(draft, widget.filters)) {
      widget.onChanged(draft);
    }

    if (draftPerson != widget.selectedUserID) {
      widget.onPersonChanged?.call(draftPerson);
    }

    if (draftType != widget.rfqType) {
      widget.onRfqTypeChanged?.call(draftType);
    }

    if (draftProject != widget.selectedProjectKey) {
      widget.onProjectChanged?.call(draftProject);
    }

    if (draftGroup != widget.groupByStatus) {
      widget.onGroupByStatusChanged?.call(draftGroup);
    }
  }

  // =========================================================
  // FIELDS
  // =========================================================

  Widget _searchField({
    String hint = 'Search RFQ #, P # or project name',
    FocusNode? focusNode,
  }) {
    return SizedBox(
      height: 44,
      child: ValueListenableBuilder<TextEditingValue>(
        valueListenable: _searchController,
        builder: (context, value, _) {
          return TextField(
            controller: _searchController,
            focusNode: focusNode,
            onChanged: widget.onSearchChanged,
            textAlignVertical: TextAlignVertical.center,
            decoration: _fieldDecoration(
              null,
              Icons.search,
            ).copyWith(
              hintText: hint,
              hintStyle: const TextStyle(
                color: Color(0xFF94A3B8),
                fontSize: 14,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 8,
              ),
              suffixIcon: value.text.isEmpty
                  ? null
                  : IconButton(
                tooltip: 'Clear search',
                icon: const Icon(
                  Icons.cancel,
                  size: 18,
                ),
                onPressed: () {
                  _searchController.clear();
                  widget.onSearchChanged?.call('');
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _sortDropdown({
    required double width,
    required AdminConfigurationFilters filters,
    required ValueChanged<AdminConfigurationFilters> onChanged,
  }) {
    return _dropdown(
      width: width,
      label: 'Sort by',
      icon: Icons.sort,
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
    );
  }

  // Disabled while Group by status is on: the status tabs
  // under the filter bar do this job then.
  Widget _statusDropdown({
    required double width,
    required AdminConfigurationFilters filters,
    required ValueChanged<AdminConfigurationFilters> onChanged,
    bool enabled = true,
  }) {
    final dropdown = _dropdown(
      width: width,
      label: 'Status',
      icon: Icons.flag_outlined,
      value: enabled
          ? filters.adminWorkflowStatus ?? 'all'
          : 'all',
      options: _statusFilters,
      enabled: enabled,
      onChanged: (value) {
        onChanged(
          filters.copyWith(
            adminWorkflowStatus: value,
          ),
        );
      },
    );

    if (enabled) {
      return dropdown;
    }

    return Tooltip(
      message: 'Using status tabs (Group by status)',
      child: dropdown,
    );
  }

  Widget _typeDropdown({
    required double width,
    required String value,
    required ValueChanged<String> onChanged,
  }) {
    return _dropdown(
      width: width,
      label: 'Type',
      icon: Icons.category_outlined,
      value: value,
      options: _rfqTypes,
      onChanged: onChanged,
    );
  }

  Widget _projectDropdown({
    required double width,
    required String? value,
    required ValueChanged<String?> onChanged,
  }) {
    return _dropdown(
      width: width,
      label: 'Project',
      icon: Icons.folder_outlined,
      value: value ?? 'all',
      options: {
        'all': 'All Projects',
        ...widget.projects,
      },
      onChanged: (value) {
        onChanged(
          value == 'all' ? null : value,
        );
      },
    );
  }

  Widget _peopleDropdown({
    required double width,
    required String? value,
    required ValueChanged<String?> onChanged,
  }) {
    return _dropdown(
      width: width,
      label: 'People',
      icon: Icons.person_outline,
      value: value ?? 'all',
      options: {
        'all': 'All People',
        ...widget.people,
      },
      onChanged: (value) {
        onChanged(
          value == 'all' ? null : value,
        );
      },
    );
  }

  Widget _dateDropdown({
    required double width,
    required AdminConfigurationFilters filters,
    required ValueChanged<AdminConfigurationFilters> onChanged,
  }) {
    return _dropdown(
      width: width,
      label: 'Date',
      icon: Icons.calendar_today_outlined,
      value: filters.dateFilter,
      options: _dateFilters,
      onChanged: (value) {
        onChanged(
          _withDateFilter(filters, value),
        );
      },
    );
  }

  List<Widget> _customDateButtons({
    required double width,
    required AdminConfigurationFilters filters,
    required ValueChanged<AdminConfigurationFilters> onChanged,
  }) {
    return [
      _dateButton(
        width: width,
        label: 'Start',
        icon: Icons.date_range_outlined,
        value: filters.startDate,
        onPicked: (date) {
          onChanged(
            _withStartDate(filters, date),
          );
        },
      ),
      _dateButton(
        width: width,
        label: 'End',
        icon: Icons.event_available_outlined,
        value: filters.endDate,
        firstDate: filters.startDate,
        onPicked: (date) {
          onChanged(
            filters.copyWith(
              endDate: date,
            ),
          );
        },
      ),
    ];
  }

  Widget _clearButton({
    int? count,
  }) {
    return SizedBox(
      height: 44,
      child: TextButton.icon(
        onPressed: _clearFilters,
        style: TextButton.styleFrom(
          foregroundColor: const Color(0xFFB91C1C),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        icon: const Icon(
          Icons.filter_alt_off_outlined,
          size: 18,
        ),
        label: Text(
          count == null
              ? 'Clear filters'
              : 'Clear filters ($count)',
          style: const TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
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
    required ValueChanged<String> onChanged,
    bool enabled = true,
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
      child: DropdownButtonFormField<String>(
        key: ValueKey(
          '$label:$safeValue',
        ),
        initialValue: safeValue,
        isDense: true,
        isExpanded: true,
        borderRadius: BorderRadius.circular(8),
        decoration: _fieldDecoration(
          label,
          icon,
        ).copyWith(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 12,
          ),
        ),
        items: options.entries
            .map(
              (entry) => DropdownMenuItem<String>(
            value: entry.key,
            child: Text(
              entry.value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        )
            .toList(),
        onChanged: enabled
            ? (value) {
          if (value != null) {
            onChanged(value);
          }
        }
            : null,
      ),
    );
  }

  // =========================================================
  // DATE BUTTON
  // =========================================================

  Widget _dateButton({
    required double width,
    required String label,
    required IconData icon,
    required DateTime? value,
    required ValueChanged<DateTime> onPicked,
    DateTime? firstDate,
  }) {
    return SizedBox(
      width: width,
      height: 44,
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          side: const BorderSide(
            color: _border,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () async {
          final now = DateTime.now();

          final selected = await showDatePicker(
            context: context,
            initialDate: value ?? firstDate ?? now,
            firstDate: firstDate ?? DateTime(2020),
            lastDate: DateTime(
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
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  // =========================================================
  // FIELD DECORATION
  // =========================================================

  InputDecoration _fieldDecoration(
      String? label,
      IconData? icon,
      ) {
    OutlineInputBorder border(Color color) {
      return OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: color,
        ),
      );
    }

    return InputDecoration(
      labelText: label,
      prefixIcon: icon == null
          ? null
          : Icon(
        icon,
        size: 20,
        color: const Color(0xFF64748B),
      ),
      border: border(_border),
      enabledBorder: border(_border),
      focusedBorder: border(_accent),
      filled: true,
      fillColor: const Color(0xFFF8FAFC),
      isDense: true,
    );
  }

  // =========================================================
  // DATE FORMAT
  // =========================================================

  static String _dateOnly(
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
        style: IconButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: onPressed,
        icon: Icon(
          descending
              ? Icons.arrow_downward
              : Icons.arrow_upward,
          size:
          compact ? 20 : 22,
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
