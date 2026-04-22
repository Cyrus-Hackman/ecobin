import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../theme/app_theme.dart';
import '../../../widgets/empty_state_widget.dart';

class NotificationListWidget extends StatefulWidget {
  final List<Map<String, dynamic>> notifications;
  final ValueChanged<String> onDismiss;
  final ValueChanged<String> onTap;

  const NotificationListWidget({
    super.key,
    required this.notifications,
    required this.onDismiss,
    required this.onTap,
  });

  @override
  State<NotificationListWidget> createState() => _NotificationListWidgetState();
}

class _NotificationListWidgetState extends State<NotificationListWidget> {
  static Color _colorFor(String colorKey) {
    switch (colorKey) {
      case 'orange':
        return AppTheme.statusEnRoute;
      case 'purple':
        return AppTheme.statusConfirmed;
      case 'gold':
        return const Color(0xFFF9A825);
      case 'green':
        return AppTheme.primaryGreen;
      case 'blue':
        return AppTheme.info;
      case 'red':
        return AppTheme.error;
      default:
        return AppTheme.primaryGreen;
    }
  }

  static IconData _iconFor(String iconKey) {
    switch (iconKey) {
      case 'local_shipping_rounded':
        return Icons.local_shipping_rounded;
      case 'check_circle_outline_rounded':
        return Icons.check_circle_outline_rounded;
      case 'stars_rounded':
        return Icons.stars_rounded;
      case 'emoji_events_rounded':
        return Icons.emoji_events_rounded;
      case 'task_alt_rounded':
        return Icons.task_alt_rounded;
      case 'info_outline_rounded':
        return Icons.info_outline_rounded;
      case 'eco_rounded':
        return Icons.eco_rounded;
      case 'warning_amber_rounded':
        return Icons.warning_amber_rounded;
      case 'cancel_outlined':
        return Icons.cancel_outlined;
      default:
        return Icons.notifications_outlined;
    }
  }

  Map<String, List<Map<String, dynamic>>> _groupByDate() {
    final groups = <String, List<Map<String, dynamic>>>{};
    for (final n in widget.notifications) {
      final date = n['date'] as String;
      groups.putIfAbsent(date, () => []).add(n);
    }
    return groups;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.notifications.isEmpty) {
      return EmptyStateWidget(
        icon: Icons.notifications_off_outlined,
        title: 'No notifications',
        description:
            'You\'re all caught up! Pickup updates and eco rewards will appear here.',
      );
    }

    final groups = _groupByDate();
    final dateOrder = ['Today', 'Yesterday', 'Earlier'];
    final orderedDates = dateOrder.where((d) => groups.containsKey(d)).toList();

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
      itemCount: orderedDates.fold<int>(
        0,
        (sum, d) => sum + 1 + (groups[d]?.length ?? 0),
      ),
      itemBuilder: (context, index) {
        int runningIndex = 0;
        for (final date in orderedDates) {
          if (index == runningIndex) {
            return _buildDateHeader(date);
          }
          runningIndex++;
          final items = groups[date]!;
          if (index < runningIndex + items.length) {
            final item = items[index - runningIndex];
            return _buildNotificationItem(item);
          }
          runningIndex += items.length;
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildDateHeader(String date) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 12, 4, 6),
      child: Text(
        date,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: AppTheme.textMuted,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildNotificationItem(Map<String, dynamic> n) {
    final isRead = n['isRead'] as bool;
    final color = _colorFor(n['color'] as String);
    final icon = _iconFor(n['icon'] as String);
    final id = n['id'] as String;

    return Dismissible(
      key: Key(id),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: AppTheme.error.withAlpha(26),
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.delete_outline_rounded, color: AppTheme.error, size: 22),
            const SizedBox(height: 2),
            Text(
              'Dismiss',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppTheme.error,
              ),
            ),
          ],
        ),
      ),
      onDismissed: (_) => widget.onDismiss(id),
      child: GestureDetector(
        onTap: () => widget.onTap(id),
        child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: isRead ? AppTheme.surface : color.withAlpha(10),
            borderRadius: BorderRadius.circular(16),
            border: Border(left: BorderSide(color: color, width: 3)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(10),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: color.withAlpha(26),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, size: 20, color: color),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              n['title'] as String,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 13,
                                fontWeight: isRead
                                    ? FontWeight.w500
                                    : FontWeight.w700,
                                color: AppTheme.textPrimary,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            n['time'] as String,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 11,
                              color: AppTheme.textMuted,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        n['body'] as String,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          color: AppTheme.textMuted,
                          height: 1.5,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                if (!isRead) ...[
                  const SizedBox(width: 8),
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
