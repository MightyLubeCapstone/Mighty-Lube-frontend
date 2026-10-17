import 'package:flutter/material.dart';

import '../../models/admin_models.dart';
import 'admin_status_style.dart';

class AdminSummaryCards extends StatelessWidget {
  const AdminSummaryCards({
    super.key,
    required this.summary,
  });

  final AdminConfigurationSummary summary;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (
          context,
          constraints,
          ) {
        final compact =
            constraints.maxWidth < 760;

        final gap =
        compact ? 6.0 : 10.0;

        final cards = <(String, int, IconData, Color)>[
          (
          'Total',
          summary.total,
          Icons.inventory_2_outlined,
          const Color(0xFF579AF6),
          ),
          (
          'Requested',
          summary.requested,
          Icons.inbox_outlined,
          AdminStatusStyle.text(AdminWorkflowStatus.requested),
          ),
          (
          'Pending',
          summary.pending,
          Icons.pending_actions,
          AdminStatusStyle.text(AdminWorkflowStatus.pending),
          ),
          (
          compact ? 'Awaiting' : 'Awaiting Response',
          summary.awaitingResponse,
          Icons.mark_email_unread_outlined,
          AdminStatusStyle.text(AdminWorkflowStatus.awaitingResponse),
          ),
          (
          'Done',
          summary.done,
          Icons.task_alt,
          AdminStatusStyle.text(AdminWorkflowStatus.done),
          ),
        ];

        final width =
            (constraints.maxWidth -
                gap * (cards.length - 1)) /
                cards.length;

        final showIcons =
            constraints.maxWidth >= 900;

        return Row(
          children: [
            for (var i = 0; i < cards.length; i++) ...[
              if (i > 0)
                SizedBox(
                  width: gap,
                ),
              _SummaryCard(
                cards[i].$1,
                cards[i].$2,
                cards[i].$3,
                cards[i].$4,
                width: width,
                showIcon: showIcons,
              ),
            ],
          ],
        );
      },
    );
  }
}

// ===========================================================
// SUMMARY CARD
// ===========================================================

class _SummaryCard extends StatelessWidget {
  const _SummaryCard(
      this.label,
      this.total,
      this.icon,
      this.color, {
        required this.width,
        required this.showIcon,
      });

  final String label;

  final int total;

  final IconData icon;

  final Color color;

  final double width;

  final bool showIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(
        horizontal: showIcon ? 18 : 6,
        vertical: showIcon ? 18 : 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
        BorderRadius.circular(
          showIcon ? 14 : 8,
        ),
        border: Border.all(
          color:
          const Color(0xFFE2E8F0),
        ),
      ),
      child: Row(
        children: [
          if (showIcon) ...[
            CircleAvatar(
              backgroundColor:
              color.withValues(
                alpha: .12,
              ),
              child: Icon(
                icon,
                color: color,
              ),
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
                  '$total',
                  maxLines: 1,
                  overflow:
                  TextOverflow.ellipsis,
                  textAlign: showIcon
                      ? TextAlign.start
                      : TextAlign.center,
                  style: TextStyle(
                    fontSize:
                    showIcon ? 25 : 19,
                    fontWeight:
                    FontWeight.w900,
                    color: color,
                  ),
                ),

                Text(
                  label,
                  maxLines: 1,
                  overflow:
                  TextOverflow.ellipsis,
                  textAlign: showIcon
                      ? TextAlign.start
                      : TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize:
                    showIcon ? 12 : 10,
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