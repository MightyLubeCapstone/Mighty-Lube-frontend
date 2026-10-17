import 'package:flutter/material.dart';

import '../../models/admin_models.dart';

// ===========================================================
// ADMIN STATUS COLOURS
//
// Row background = admin status colour:
//
// Requested         -> amber
// Pending           -> red
// Awaiting Response -> blue
// Done              -> green
//
// Projects use purple (header row + left border) so they
// never clash with the status colours.
// ===========================================================

class AdminStatusStyle {
  AdminStatusStyle._();

  static const Color projectColor = Color(0xFF7C3AED);

  static const Color projectBackground = Color(0xFFF5F3FF);

  static const Color projectHover = Color(0xFFEDE9FE);

  static const Color projectBorder = Color(0xFFDDD6FE);

  static Color text(
      String? status,
      ) {
    switch (status) {
      case AdminWorkflowStatus.requested:
        return const Color(0xFFD97706);

      case AdminWorkflowStatus.pending:
        return const Color(0xFFDC2626);

      case AdminWorkflowStatus.awaitingResponse:
        return const Color(0xFF2563EB);

      case AdminWorkflowStatus.done:
        return const Color(0xFF15803D);

      default:
        return const Color(0xFF475569);
    }
  }

  static Color row(
      String? status,
      ) {
    switch (status) {
      case AdminWorkflowStatus.requested:
        return const Color(0xFFFFFBEB);

      case AdminWorkflowStatus.pending:
        return const Color(0xFFFEF2F2);

      case AdminWorkflowStatus.awaitingResponse:
        return const Color(0xFFEFF6FF);

      case AdminWorkflowStatus.done:
        return const Color(0xFFF0FDF4);

      default:
        return Colors.white;
    }
  }

  static Color hover(
      String? status,
      ) {
    switch (status) {
      case AdminWorkflowStatus.requested:
        return const Color(0xFFFEF3C7);

      case AdminWorkflowStatus.pending:
        return const Color(0xFFFEE2E2);

      case AdminWorkflowStatus.awaitingResponse:
        return const Color(0xFFDBEAFE);

      case AdminWorkflowStatus.done:
        return const Color(0xFFDCFCE7);

      default:
        return const Color(0xFFF8FAFC);
    }
  }

  static Color border(
      String? status,
      ) {
    switch (status) {
      case AdminWorkflowStatus.requested:
        return const Color(0xFFFDE68A);

      case AdminWorkflowStatus.pending:
        return const Color(0xFFFECACA);

      case AdminWorkflowStatus.awaitingResponse:
        return const Color(0xFFBFDBFE);

      case AdminWorkflowStatus.done:
        return const Color(0xFFBBF7D0);

      default:
        return const Color(0xFFE2E8F0);
    }
  }
}

// ===========================================================
// CONFIRM STATUS CHANGE
//
// Awaiting Response sends an email to the RFQ creator, so the
// admin confirms first. Other statuses change immediately.
// ===========================================================

Future<bool> confirmAdminStatusChange(
    BuildContext context, {
      required AdminConfiguration configuration,
      required String newStatus,
    }) async {
  if (newStatus != AdminWorkflowStatus.awaitingResponse) {
    return true;
  }

  final userName =
  adminConfigurationUserName(configuration);

  final rfq = configuration.rfqLabel;

  final confirmed = await showDialog<bool>(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        icon: const Icon(
          Icons.mark_email_unread_outlined,
          color: Color(0xFF2563EB),
          size: 40,
        ),
        title: const Text(
          'Mark as Awaiting Response?',
          textAlign: TextAlign.center,
        ),
        content: Text(
          'An email will be sent to $userName'
              '${rfq == null ? '' : ' for $rfq'}. Continue?',
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.pop(
                  dialogContext,
                  false,
                ),
            child: const Text('Cancel'),
          ),
          FilledButton.icon(
            onPressed: () =>
                Navigator.pop(
                  dialogContext,
                  true,
                ),
            icon: const Icon(
              Icons.send_outlined,
              size: 18,
            ),
            label: const Text('Continue'),
          ),
        ],
      );
    },
  );

  return confirmed ?? false;
}

// ===========================================================
// USER NAME
// ===========================================================

String adminConfigurationUserName(
    AdminConfiguration configuration, [
      List<AdminUser> users = const [],
    ]) {
  for (final user in users) {
    if (user.userID == configuration.userID &&
        user.name != '—') {
      return user.name;
    }
  }

  final createdBy = configuration.createdBy;

  final firstName =
      createdBy?['firstName']?.toString().trim() ?? '';

  final lastName =
      createdBy?['lastName']?.toString().trim() ?? '';

  final fullName = '$firstName $lastName'.trim();

  if (fullName.isNotEmpty) {
    return fullName;
  }

  final username =
      createdBy?['username']?.toString().trim() ?? '';

  return username.isNotEmpty
      ? username
      : 'the user';
}

// ===========================================================
// STANDALONE TAG
// ===========================================================

class AdminStandaloneTag extends StatelessWidget {
  const AdminStandaloneTag({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 7,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFCBD5E1),
        ),
      ),
      child: const Text(
        'Standalone',
        style: TextStyle(
          color: Color(0xFF475569),
          fontSize: 10,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

// ===========================================================
// PROJECT STATUS SUMMARY
//
// e.g. ● 1 Pending  ● 2 Done
// ===========================================================

class AdminProjectStatusSummary extends StatelessWidget {
  const AdminProjectStatusSummary({
    super.key,
    required this.group,
    this.alignment = WrapAlignment.center,
  });

  final AdminProjectGroup group;

  final WrapAlignment alignment;

  @override
  Widget build(BuildContext context) {
    final counts = group.statusCounts;

    return Wrap(
      alignment: alignment,
      spacing: 8,
      runSpacing: 4,
      children: [
        for (final entry in counts.entries)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 7,
                height: 7,
                decoration: BoxDecoration(
                  color: AdminStatusStyle.text(
                    entry.key,
                  ),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  '${entry.value} '
                      '${AdminWorkflowStatus.label(entry.key)}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AdminStatusStyle.text(
                      entry.key,
                    ),
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
