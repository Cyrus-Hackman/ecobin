import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../theme/app_theme.dart';
import '../../../widgets/status_badge_widget.dart';

class HomeRecentPickupsWidget extends StatelessWidget {
  final VoidCallback onViewAll;

  const HomeRecentPickupsWidget({super.key, required this.onViewAll});

  static final List<Map<String, dynamic>> _recentPickupMaps = [
    {
      'id': 'ECO-2847',
      'wasteType': 'General Waste',
      'address': '742 Evergreen Terrace',
      'date': 'Today, 2:30 PM',
      'status': 'enRoute',
      'points': 50,
      'icon': 'delete_outline_rounded',
    },
    {
      'id': 'ECO-2831',
      'wasteType': 'Recycling',
      'address': '742 Evergreen Terrace',
      'date': 'Apr 14, 10:15 AM',
      'status': 'completed',
      'points': 120,
      'icon': 'recycling_rounded',
    },
    {
      'id': 'ECO-2819',
      'wasteType': 'Yard Waste',
      'address': '742 Evergreen Terrace',
      'date': 'Apr 10, 9:00 AM',
      'status': 'completed',
      'points': 80,
      'icon': 'grass_rounded',
    },
  ];

  static PickupStatus _statusFromString(String s) {
    switch (s) {
      case 'enRoute':
        return PickupStatus.enRoute;
      case 'completed':
        return PickupStatus.completed;
      case 'confirmed':
        return PickupStatus.confirmed;
      case 'cancelled':
        return PickupStatus.cancelled;
      default:
        return PickupStatus.requested;
    }
  }

  static Color _wasteColor(String type) {
    switch (type) {
      case 'Recycling':
        return const Color(0xFF0277BD);
      case 'Yard Waste':
        return AppTheme.secondaryLime;
      case 'Hazardous':
        return AppTheme.warning;
      default:
        return AppTheme.primaryGreen;
    }
  }

  @override
  Widget build(BuildContext context) {
    final pickups = _recentPickupMaps;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Pickups',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppTheme.textPrimary,
              ),
            ),
            TextButton(
              onPressed: onViewAll,
              style: TextButton.styleFrom(
                foregroundColor: AppTheme.primaryGreen,
                padding: EdgeInsets.zero,
                minimumSize: const Size(0, 0),
              ),
              child: Text(
                'View all',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.primaryGreen,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        ...pickups.map((p) {
          final status = _statusFromString(p['status'] as String);
          final wasteType = p['wasteType'] as String;
          final color = _wasteColor(wasteType);
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppTheme.surface,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(13),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: color.withAlpha(26),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    wasteType == 'Recycling'
                        ? Icons.recycling_rounded
                        : wasteType == 'Yard Waste'
                        ? Icons.grass_rounded
                        : Icons.delete_outline_rounded,
                    size: 22,
                    color: color,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '#${p['id']}',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(width: 8),
                          StatusBadgeWidget(status: status, compact: true),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Text(
                        '${p['address']} · $wasteType',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          color: AppTheme.textMuted,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        p['date'] as String,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11,
                          color: AppTheme.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF9A825).withAlpha(26),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.stars_rounded,
                        size: 12,
                        color: Color(0xFFF9A825),
                      ),
                      const SizedBox(width: 3),
                      Text(
                        '+${p['points']}',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFFF9A825),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
