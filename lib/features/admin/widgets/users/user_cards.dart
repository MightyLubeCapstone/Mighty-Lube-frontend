import 'package:flutter/material.dart';

import '../../models/admin_models.dart';

class UserCards extends StatelessWidget {
  const UserCards({
    super.key,
    required this.users,
    required this.roles,
    required this.updatingUserIDs,
    required this.deletingUserIDs,
    required this.onRoleChanged,
    required this.onView,
    required this.onEdit,
    required this.onDelete,
  });

  final List<AdminUser> users;

  final List<String> roles;

  final Set<String> updatingUserIDs;

  final Set<String> deletingUserIDs;

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
    if (users.isEmpty) {
      return const _AdminListCard(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 28,
          ),
          child: Center(
            child: Text(
              'No users found.',
            ),
          ),
        ),
      );
    }

    return Column(
      children: [
        for (final user in users)
          _userCard(user),
      ],
    );
  }

  // =========================================================
  // USER CARD
  // =========================================================

  Widget _userCard(
      AdminUser user,
      ) {
    return _AdminListCard(
      margin: const EdgeInsets.only(
        bottom: 12,
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  user.name,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight:
                    FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              _RoleBadge(
                user.role,
              ),
            ],
          ),

          const SizedBox(
            height: 12,
          ),

          _InfoLine(
            icon:
            Icons.alternate_email,
            label: 'Username',
            value: user.username,
          ),

          _InfoLine(
            icon:
            Icons.email_outlined,
            label: 'Email',
            value: user.email,
          ),

          _InfoLine(
            icon:
            Icons.phone_outlined,
            label: 'Phone',
            value: user.phone,
          ),

          _InfoLine(
            icon:
            Icons.business_outlined,
            label: 'Company',
            value: user.company,
          ),

          _InfoLine(
            icon:
            Icons.add_circle_outline,
            label: 'Created',
            value: _date(
              user.createdAt,
            ),
          ),

          _InfoLine(
            icon: Icons.update,
            label: 'Updated',
            value: _date(
              user.updatedAt,
            ),
          ),

          const SizedBox(
            height: 12,
          ),

          _userRoleControl(
            user,
          ),

          const Divider(
            height: 24,
          ),

          _userActions(
            user,
          ),
        ],
      ),
    );
  }

  // =========================================================
  // ROLE CONTROL
  // =========================================================

  Widget _userRoleControl(
      AdminUser user,
      ) {
    if (updatingUserIDs.contains(
      user.userID,
    )) {
      return const SizedBox.square(
        dimension: 22,
        child:
        CircularProgressIndicator(
          strokeWidth: 2,
        ),
      );
    }

    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: roles.contains(
          user.role,
        )
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
                  _titleCase(
                    value,
                  ),
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
  // USER ACTIONS
  // =========================================================

  Widget _userActions(
      AdminUser user,
      ) {
    if (deletingUserIDs.contains(
      user.userID,
    )) {
      return const SizedBox.square(
        dimension: 22,
        child:
        CircularProgressIndicator(
          strokeWidth: 2,
        ),
      );
    }

    return SizedBox(
      width: 132,
      child: Row(
        mainAxisSize:
        MainAxisSize.min,
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
              color:
              Color(0xFF2563EB),
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

// ===========================================================
// INFO LINE
// ===========================================================

class _InfoLine
    extends StatelessWidget {
  const _InfoLine({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;

  final String label;

  final String value;

  @override
  Widget build(
      BuildContext context,
      ) {
    return Padding(
      padding:
      const EdgeInsets.only(
        bottom: 8,
      ),
      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 18,
            color:
            const Color(0xFF64748B),
          ),

          const SizedBox(
            width: 8,
          ),

          SizedBox(
            width: 78,
            child: Text(
              label,
              style:
              const TextStyle(
                color:
                Color(0xFF64748B),
                fontSize: 12,
                fontWeight:
                FontWeight.w700,
              ),
            ),
          ),

          const SizedBox(
            width: 6,
          ),

          Expanded(
            child: Text(
              value.trim().isEmpty
                  ? '—'
                  : value,
              style:
              const TextStyle(
                fontSize: 13,
                fontWeight:
                FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================
// ROLE BADGE
// ===========================================================

class _RoleBadge
    extends StatelessWidget {
  const _RoleBadge(
      this.role,
      );

  final String role;

  @override
  Widget build(
      BuildContext context,
      ) {
    final MaterialColor color =
    role == 'admin'
        ? Colors.deepPurple
        : Colors.blueGrey;

    return Container(
      padding:
      const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color:
        color.withOpacity(.12),
        borderRadius:
        BorderRadius.circular(30),
      ),
      child: Text(
        _titleCaseValue(
          role,
        ),
        maxLines: 1,
        overflow:
        TextOverflow.ellipsis,
        style: TextStyle(
          color: color.shade700,
          fontWeight:
          FontWeight.w700,
        ),
      ),
    );
  }

  String _titleCaseValue(
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

// ===========================================================
// CARD CONTAINER
// ===========================================================

class _AdminListCard
    extends StatelessWidget {
  const _AdminListCard({
    required this.child,
    this.margin = EdgeInsets.zero,
  });

  final Widget child;

  final EdgeInsetsGeometry margin;

  @override
  Widget build(
      BuildContext context,
      ) {
    return Container(
      width: double.infinity,
      margin: margin,
      padding:
      const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
        BorderRadius.circular(14),
        border: Border.all(
          color:
          const Color(0xFFE2E8F0),
        ),
      ),
      child: child,
    );
  }
}