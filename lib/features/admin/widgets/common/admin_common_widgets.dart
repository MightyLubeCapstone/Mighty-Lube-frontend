import 'package:flutter/material.dart';

/// Common reusable widgets/helpers for Admin UI.
///
/// Keep only truly shared/presentational components here.
/// Configuration-specific and User-specific UI should stay
/// inside their respective folders.

// ===========================================================
// ADMIN LIST CARD
// ===========================================================

class AdminListCard extends StatelessWidget {
  const AdminListCard({
    super.key,
    required this.child,
    this.margin = EdgeInsets.zero,
    this.padding = const EdgeInsets.all(16),
  });

  final Widget child;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
        ),
      ),
      child: child,
    );
  }
}

// ===========================================================
// ADMIN DETAILS DIALOG
// ===========================================================

class AdminDetailsDialog extends StatelessWidget {
  const AdminDetailsDialog({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.sizeOf(context);
    final compact = screen.width < 560;

    return Dialog(
      insetPadding: EdgeInsets.all(
        compact ? 8 : 16,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 780,
          maxHeight: screen.height - (compact ? 24 : 48),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AdminDialogHeader(
              icon: icon,
              title: title,
              subtitle: subtitle,
            ),

            Flexible(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(
                  compact ? 14 : 24,
                ),
                child: child,
              ),
            ),

            const Divider(
              height: 1,
            ),

            Padding(
              padding: EdgeInsets.all(
                compact ? 12 : 16,
              ),
              child: Align(
                alignment: Alignment.centerRight,
                child: FilledButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.check,
                  ),
                  label: const Text(
                    'Done',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ===========================================================
// ADMIN EDIT DIALOG
// ===========================================================

class AdminEditDialog extends StatelessWidget {
  const AdminEditDialog({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onSave,
    required this.child,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onSave;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.sizeOf(context);
    final compact = screen.width < 560;

    return Dialog(
      insetPadding: EdgeInsets.all(
        compact ? 8 : 16,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 780,
          maxHeight: screen.height - (compact ? 24 : 48),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AdminDialogHeader(
              icon: icon,
              title: title,
              subtitle: subtitle,
            ),

            Flexible(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(
                  compact ? 14 : 24,
                ),
                child: child,
              ),
            ),

            const Divider(
              height: 1,
            ),

            Padding(
              padding: EdgeInsets.all(
                compact ? 12 : 16,
              ),
              child: Wrap(
                alignment: WrapAlignment.end,
                spacing: 10,
                runSpacing: 8,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Cancel',
                    ),
                  ),
                  FilledButton.icon(
                    onPressed: onSave,
                    icon: const Icon(
                      Icons.save_outlined,
                    ),
                    label: const Text(
                      'Save changes',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ===========================================================
// DIALOG HEADER
// ===========================================================

class AdminDialogHeader extends StatelessWidget {
  const AdminDialogHeader({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final compact =
        MediaQuery.sizeOf(context).width < 560;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        compact ? 16 : 24,
        compact ? 16 : 20,
        8,
        compact ? 14 : 18,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFFF1F5FF),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Row(
        children: [
          if (!compact) ...[
            CircleAvatar(
              backgroundColor: const Color(
                0xFF2563EB,
              ),
              foregroundColor: Colors.white,
              child: Icon(icon),
            ),
            const SizedBox(
              width: 14,
            ),
          ],

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: compact ? 18 : 21,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(
                      0xFF64748B,
                    ),
                  ),
                ),
              ],
            ),
          ),

          IconButton(
            tooltip: 'Close',
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.close,
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================
// SECTION TITLE
// ===========================================================

class AdminSectionTitle extends StatelessWidget {
  const AdminSectionTitle({
    super.key,
    required this.icon,
    required this.title,
  });

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: const Color(
            0xFF2563EB,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}

// ===========================================================
// STATUS BADGE
// ===========================================================

class AdminStatusBadge extends StatelessWidget {
  const AdminStatusBadge({
    super.key,
    required this.status,
  });

  final String status;

  @override
  Widget build(BuildContext context) {
    final normalized = status
        .trim()
        .toLowerCase();

    final MaterialColor color =
    switch (normalized) {
      'done' => Colors.green,
      'pending' => Colors.orange,
      'requested' => Colors.blue,
      'admin' => Colors.deepPurple,
      _ => Colors.blueGrey,
    };

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(.12),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        adminTitleCase(status),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: color.shade700,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

// ===========================================================
// TABLE CONTAINER
// ===========================================================

class AdminTableContainer extends StatelessWidget {
  const AdminTableContainer({
    super.key,
    required this.empty,
    required this.emptyText,
    required this.table,
  });

  final bool empty;
  final String emptyText;
  final DataTable table;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
        ),
      ),
      child: empty
          ? Padding(
        padding: const EdgeInsets.all(48),
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
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: constraints.maxWidth,
              ),
              child: table,
            ),
          );
        },
      ),
    );
  }
}

// ===========================================================
// RESPONSIVE TABLE TEXT
// ===========================================================

class AdminResponsiveText extends StatelessWidget {
  const AdminResponsiveText({
    super.key,
    required this.value,
    required this.fraction,
    required this.minimum,
    required this.maximum,
    this.maxLines = 1,
  });

  final String value;
  final double fraction;
  final double minimum;
  final double maximum;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    final width =
    (MediaQuery.sizeOf(context).width * fraction)
        .clamp(
      minimum,
      maximum,
    );

    final displayValue =
    value.trim().isEmpty ? '—' : value;

    return SizedBox(
      width: width,
      child: Tooltip(
        message: displayValue,
        child: Text(
          displayValue,
          maxLines: maxLines,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

// ===========================================================
// COMMON HELPERS
// ===========================================================

double adminCompactFieldWidth(
    double maxWidth,
    ) {
  if (maxWidth < 520) {
    return maxWidth;
  }

  return ((maxWidth - 24) / 3).clamp(
    190.0,
    240.0,
  );
}

double adminColumnSpacing(
    BuildContext context,
    ) {
  return MediaQuery.sizeOf(context).width >= 1200
      ? 24
      : 12;
}

String adminTitleCase(
    String value,
    ) {
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
    '${part[0].toUpperCase()}'
        '${part.substring(1).toLowerCase()}',
  )
      .join(' ');
}

String adminReadableLabel(
    String key,
    ) {
  const overrides = {
    'cc5ChainSize': 'CC5 chain size',
    'appEnviroment': 'Application environment',
    'numRequested': 'Quantity requested',
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

String adminDate(
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

String adminFriendlyDate(
    dynamic raw,
    ) {
  if (raw == null) {
    return '—';
  }

  final date = raw is DateTime
      ? raw
      : DateTime.tryParse(
    raw.toString(),
  );

  if (date == null) {
    return '—';
  }

  final local = date.toLocal();

  String twoDigits(
      int value,
      ) {
    return value
        .toString()
        .padLeft(
      2,
      '0',
    );
  }

  return '${twoDigits(local.month)}/'
      '${twoDigits(local.day)}/'
      '${local.year} '
      '${twoDigits(local.hour)}:'
      '${twoDigits(local.minute)}';
}

String? adminElapsedAge(
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

bool adminIsNested(
    dynamic value,
    ) {
  return value is Map || value is List;
}