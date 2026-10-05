import 'package:flutter/material.dart';

import '../../models/admin_models.dart';
import 'configuration_cards.dart';
import 'configuration_table.dart';

class ConfigurationList extends StatelessWidget {
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
  });

  // =========================================================
  // GROUP ORDER
  //
  // 1. Pending
  // 2. Requested
  // 3. Done
  // =========================================================
  static const List<String> _statuses = [
    'pending',
    'requested',
    'done',
  ];

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

  @override
  Widget build(BuildContext context) {
    if (!groupByStatus) {
      return _buildList(items);
    }

    final sections = [
      for (final status in _statuses)
        MapEntry(
          status,
          items
              .where(
                (item) =>
            (item.adminWorkflowStatus ?? 'requested') ==
                status,
          )
              .toList(),
        ),
    ]
        .where(
          (entry) => entry.value.isNotEmpty,
    )
        .toList();

    if (sections.isEmpty) {
      return const _EmptyConfigurationCard(
        text: 'No configurations found.',
      );
    }

    return Column(
      children: [
        for (final section in sections) ...[
          _StatusSectionHeader(
            status: section.key,
            count: section.value.length,
          ),

          const SizedBox(
            height: 10,
          ),

          _buildList(
            section.value,
          ),

          const SizedBox(
            height: 18,
          ),
        ],
      ],
    );
  }

  // =========================================================
  // TABLE / CARDS
  // =========================================================

  Widget _buildList(
      List<AdminConfiguration> configurations,
      ) {
    if (compact) {
      return ConfigurationCards(
        items: configurations,
        updatingConfigurationIDs:
        updatingConfigurationIDs,
        deletingConfigurationIDs:
        deletingConfigurationIDs,
        onStatusChanged:
        onStatusChanged,
        onView:
        onViewConfiguration,
        onEdit:
        onEditConfiguration,
        onDelete:
        onDeleteConfiguration,
      );
    }

    return ConfigurationTable(
      items: configurations,
      users: users,
      updatingConfigurationIDs:
      updatingConfigurationIDs,
      deletingConfigurationIDs:
      deletingConfigurationIDs,
      imageCountFor:
      imageCountFor,
      onStatusChanged:
      onStatusChanged,
      onViewConfiguration:
      onViewConfiguration,
      onViewImages:
      onViewImages,
      onEditConfiguration:
      onEditConfiguration,
      onDeleteConfiguration:
      onDeleteConfiguration,
      onViewUser:
      onViewUser,
    );
  }
}

// ===========================================================
// STATUS SECTION HEADER
// ===========================================================

class _StatusSectionHeader extends StatelessWidget {
  const _StatusSectionHeader({
    required this.status,
    required this.count,
  });

  final String status;

  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: _sectionBackgroundColor(status),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: _sectionBorderColor(status),
        ),
      ),
      child: Row(
        children: [
          _StatusBadge(
            status,
          ),

          const SizedBox(
            width: 10,
          ),

          Text(
            '$count configuration'
                '${count == 1 ? '' : 's'}',
            style: const TextStyle(
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Color _sectionBackgroundColor(String status) {
    switch (status.trim().toLowerCase()) {
      case 'pending':
        return const Color(0xFFFEF2F2);

      case 'requested':
        return const Color(0xFFFFFBEB);

      case 'done':
        return const Color(0xFFF0FDF4);

      default:
        return const Color(0xFFF8FAFC);
    }
  }

  Color _sectionBorderColor(String status) {
    switch (status.trim().toLowerCase()) {
      case 'pending':
        return const Color(0xFFFECACA);

      case 'requested':
        return const Color(0xFFFDE68A);

      case 'done':
        return const Color(0xFFBBF7D0);

      default:
        return const Color(0xFFE2E8F0);
    }
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
    final normalized =
    status.trim().toLowerCase();

    Color textColor;
    Color backgroundColor;

    switch (normalized) {
      case 'pending':
        textColor = const Color(0xFFDC2626);
        backgroundColor = const Color(0xFFFEE2E2);
        break;

      case 'requested':
        textColor = const Color(0xFFD97706);
        backgroundColor = const Color(0xFFFEF3C7);
        break;

      case 'done':
        textColor = const Color(0xFF15803D);
        backgroundColor = const Color(0xFFDCFCE7);
        break;

      default:
        textColor = const Color(0xFF475569);
        backgroundColor = const Color(0xFFF1F5F9);
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        _titleCase(status),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w700,
        ),
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

// ===========================================================
// HELPERS
// ===========================================================

String _titleCase(
    String value,
    ) {
  if (value.isEmpty) {
    return value;
  }

  return '${value[0].toUpperCase()}'
      '${value.substring(1).toLowerCase()}';
}