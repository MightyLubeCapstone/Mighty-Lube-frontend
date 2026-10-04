
import 'package:flutter/material.dart';

import '../../models/admin_models.dart';

class UserTable extends StatelessWidget {
  const UserTable({
    super.key,
    required this.users,
    required this.updatingUserIDs,
    required this.deletingUserIDs,
    required this.roles,
    required this.onRoleChanged,
    required this.onView,
    required this.onEdit,
    required this.onDelete,
  });

  final List<AdminUser> users;

  final Set<String> updatingUserIDs;
  final Set<String> deletingUserIDs;

  final List<String> roles;

  final void Function(
      AdminUser user,
      String? role,
      ) onRoleChanged;

  final void Function(
      AdminUser user,
      ) onView;

  final void Function(
      AdminUser user,
      ) onEdit;

  final void Function(
      AdminUser user,
      ) onDelete;

  @override
  Widget build(BuildContext context) {
    return _tableContainer(
      empty: users.isEmpty,
      emptyText: 'No users found.',
      table: DataTable(
        columnSpacing: _columnSpacing(
          context,
        ),
        horizontalMargin: 12,
        headingRowHeight: 44,
        dataRowMinHeight: 54,
        dataRowMaxHeight: 58,
        dividerThickness: .65,
        columns: const [
          DataColumn(
            label: Text('Name'),
          ),
          DataColumn(
            label: Text('Username'),
          ),
          DataColumn(
            label: Text('Email'),
          ),
          DataColumn(
            label: Text('Company'),
          ),
          DataColumn(
            label: Text('Created'),
          ),
          DataColumn(
            label: Text('Role'),
          ),
          DataColumn(
            label: Text('Actions'),
          ),
        ],
        rows: users
            .map(
              (user) => _userRow(
            context,
            user,
          ),
        )
            .toList(),
      ),
    );
  }

// =========================================================
// USER ROW
// =========================================================

  DataRow _userRow(
      BuildContext context,
      AdminUser user,
      ) {
    return DataRow(
      cells: [
        DataCell(
          _responsiveText(
            context,
            user.name,
            .11,
            100,
            180,
          ),
        ),

        DataCell(
          _responsiveText(
            context,
            user.username,
            .13,
            125,
            210,
          ),
        ),

        DataCell(
          _responsiveText(
            context,
            user.email,
            .14,
            135,
            230,
          ),
        ),

        DataCell(
          _responsiveText(
            context,
            user.company,
            .12,
            110,
            200,
          ),
        ),

        DataCell(
          _responsiveText(
            context,
            _date(user.createdAt),
            .12,
            125,
            190,
          ),
        ),

        DataCell(
          _roleControl(user),
        ),

        DataCell(
          _actions(user),
        ),
      ],
    );
  }

// =========================================================
// ROLE CONTROL
// =========================================================

  Widget _roleControl(
      AdminUser user,
      ) {
    if (updatingUserIDs.contains(
      user.userID,
    )) {
      return const SizedBox.square(
        dimension: 22,
        child: CircularProgressIndicator(
          strokeWidth: 2,
        ),
      );
    }

    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: roles.contains(user.role)
            ? user.role
            : null,
        hint: Text(
          user.role,
        ),
        items: roles
            .map(
              (value) =>
              DropdownMenuItem<String>(
                value: value,
                child: Text(
                  _titleCase(value),
                ),
              ),
        )
            .toList(),
        onChanged: (value) =>
            onRoleChanged(
              user,
              value,
            ),
      ),
    );
  }

// =========================================================
// ACTIONS
// =========================================================

  Widget _actions(
      AdminUser user,
      ) {
    if (deletingUserIDs.contains(
      user.userID,
    )) {
      return const SizedBox.square(
        dimension: 22,
        child: CircularProgressIndicator(
          strokeWidth: 2,
        ),
      );
    }

    return SizedBox(
      width: 132,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            tooltip: 'View user',
            onPressed: () =>
                onView(user),
            icon: const Icon(
              Icons.visibility_outlined,
            ),
          ),

          IconButton(
            tooltip: 'Edit user',
            onPressed: () =>
                onEdit(user),
            icon: const Icon(
              Icons.edit_outlined,
              color: Color(
                0xFF2563EB,
              ),
            ),
          ),

          IconButton(
            tooltip: 'Delete user',
            onPressed: () =>
                onDelete(user),
            icon: const Icon(
              Icons.delete_outline,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

// =========================================================
// TABLE CONTAINER
// =========================================================

  Widget _tableContainer({
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
          color:
          const Color(0xFFE2E8F0),
        ),
      ),
      child: empty
          ? Padding(
        padding:
        const EdgeInsets.all(48),
        child: Center(
          child: Text(
            emptyText,
          ),
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
              constraints:
              BoxConstraints(
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
// RESPONSIVE TEXT
// =========================================================

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
          value.trim().isEmpty
              ? '—'
              : value,
          maxLines: 1,
          overflow:
          TextOverflow.ellipsis,
        ),
      ),
    );
  }

  double _columnSpacing(
      BuildContext context,
      ) {
    return MediaQuery.sizeOf(context)
        .width >=
        1200
        ? 24
        : 12;
  }

// =========================================================
// HELPERS
// =========================================================

  String _date(
      DateTime? value,
      ) {
    if (value == null) {
      return '—';
    }

    final local = value.toLocal();

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

    return '${twoDigits(local.month)}/'
        '${twoDigits(local.day)}/'
        '${local.year}';
  }

  String _titleCase(
      String value,
      ) {
    if (value.trim().isEmpty) {
      return value;
    }

    return value
        .split(' ')
        .where(
          (part) =>
      part.isNotEmpty,
    )
        .map(
          (part) =>
      '${part[0].toUpperCase()}'
          '${part.substring(1).toLowerCase()}',
    )
        .join(' ');
  }
}
