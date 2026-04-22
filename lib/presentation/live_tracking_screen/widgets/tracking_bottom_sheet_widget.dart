import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../theme/app_theme.dart';

class TrackingBottomSheetWidget extends StatelessWidget {
  final int etaMinutes;
  final bool isExpanded;
  final VoidCallback onToggleExpand;
  final VoidCallback onContactDriver;
  final VoidCallback onCancelPickup;

  const TrackingBottomSheetWidget({
    super.key,
    required this.etaMinutes,
    required this.isExpanded,
    required this.onToggleExpand,
    required this.onContactDriver,
    required this.onCancelPickup,
  });

  static const List<Map<String, dynamic>> _statusSteps = [
    {
      'label': 'Request Confirmed',
      'time': '2:18 PM',
      'done': true,
      'icon': Icons.check_circle_rounded,
    },
    {
      'label': 'Truck En Route',
      'time': '2:24 PM',
      'done': true,
      'icon': Icons.local_shipping_rounded,
    },
    {
      'label': 'Arriving Soon',
      'time': 'ETA ~12 min',
      'done': false,
      'icon': Icons.location_on_rounded,
    },
    {
      'label': 'Pickup Complete',
      'time': 'Pending',
      'done': false,
      'icon': Icons.task_alt_rounded,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        boxShadow: [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 24,
            offset: Offset(0, -6),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: onToggleExpand,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppTheme.textMuted.withAlpha(77),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ETA Hero
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppTheme.statusEnRoute.withAlpha(20),
                        AppTheme.primaryGreen.withAlpha(15),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppTheme.statusEnRoute.withAlpha(51),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: AppTheme.statusEnRoute.withAlpha(31),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(
                          Icons.local_shipping_rounded,
                          color: AppTheme.statusEnRoute,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Truck is on the way',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Driver: Marcus Okonkwo',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 12,
                                color: AppTheme.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '~$etaMinutes',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 32,
                              fontWeight: FontWeight.w800,
                              color: AppTheme.statusEnRoute,
                              fontFeatures: [
                                const FontFeature.tabularFigures(),
                              ],
                            ),
                          ),
                          Text(
                            'minutes',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 11,
                              color: AppTheme.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                // Status Timeline
                Text(
                  'Pickup Progress',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                ..._statusSteps.asMap().entries.map((entry) {
                  final i = entry.key;
                  final step = entry.value;
                  final isDone = step['done'] as bool;
                  final isLast = i == _statusSteps.length - 1;
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              color: isDone
                                  ? AppTheme.primaryGreen
                                  : i == 2
                                  ? AppTheme.statusEnRoute.withAlpha(38)
                                  : AppTheme.surfaceVariant,
                              shape: BoxShape.circle,
                              border: i == 2
                                  ? Border.all(
                                      color: AppTheme.statusEnRoute,
                                      width: 2,
                                    )
                                  : null,
                            ),
                            child: Icon(
                              step['icon'] as IconData,
                              size: 14,
                              color: isDone
                                  ? Colors.white
                                  : i == 2
                                  ? AppTheme.statusEnRoute
                                  : AppTheme.textMuted,
                            ),
                          ),
                          if (!isLast)
                            Container(
                              width: 2,
                              height: 24,
                              color: isDone
                                  ? AppTheme.primaryGreen.withAlpha(77)
                                  : AppTheme.surfaceVariant,
                            ),
                        ],
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            bottom: isLast ? 0 : 16,
                            top: 4,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                step['label'] as String,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 13,
                                  fontWeight: isDone
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                                  color: isDone
                                      ? AppTheme.textPrimary
                                      : i == 2
                                      ? AppTheme.statusEnRoute
                                      : AppTheme.textMuted,
                                ),
                              ),
                              Text(
                                step['time'] as String,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 11,
                                  color: isDone
                                      ? AppTheme.primaryGreen
                                      : AppTheme.textMuted,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }),
                const SizedBox(height: 18),
                // Action buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: onContactDriver,
                        icon: const Icon(Icons.call_rounded, size: 16),
                        label: Text(
                          'Contact Driver',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppTheme.primaryGreen,
                          side: const BorderSide(
                            color: AppTheme.primaryGreen,
                            width: 1.5,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: onCancelPickup,
                        icon: const Icon(Icons.cancel_outlined, size: 16),
                        label: Text(
                          'Cancel',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppTheme.error,
                          side: BorderSide(
                            color: AppTheme.error.withAlpha(128),
                            width: 1.5,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
