import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../theme/app_theme.dart';

class EcoActivityLogWidget extends StatelessWidget {
  const EcoActivityLogWidget({super.key});

  static final List<Map<String, dynamic>> _activityMaps = [
    {
      'id': 'a1',
      'action': 'Recycling pickup completed',
      'points': 120,
      'date': 'Apr 14, 2026',
      'icon': 'recycling_rounded',
      'color': 'blue',
      'positive': true,
    },
    {
      'id': 'a2',
      'action': 'Badge unlocked: Recycling Hero',
      'points': 50,
      'date': 'Apr 14, 2026',
      'icon': 'emoji_events_rounded',
      'color': 'gold',
      'positive': true,
    },
    {
      'id': 'a3',
      'action': 'Yard waste pickup completed',
      'points': 80,
      'date': 'Apr 10, 2026',
      'icon': 'grass_rounded',
      'color': 'lime',
      'positive': true,
    },
    {
      'id': 'a4',
      'action': 'General waste pickup completed',
      'points': 50,
      'date': 'Apr 7, 2026',
      'icon': 'delete_outline_rounded',
      'color': 'green',
      'positive': true,
    },
    {
      'id': 'a5',
      'action': 'Weekly eco streak bonus',
      'points': 100,
      'date': 'Apr 6, 2026',
      'icon': 'local_fire_department_rounded',
      'color': 'orange',
      'positive': true,
    },
    {
      'id': 'a6',
      'action': 'Pickup cancelled — penalty',
      'points': -20,
      'date': 'Apr 3, 2026',
      'icon': 'cancel_outlined',
      'color': 'red',
      'positive': false,
    },
    {
      'id': 'a7',
      'action': 'Recycling pickup completed',
      'points': 120,
      'date': 'Mar 28, 2026',
      'icon': 'recycling_rounded',
      'color': 'blue',
      'positive': true,
    },
  ];

  static Color _colorFor(String c) {
    switch (c) {
      case 'blue':
        return AppTheme.info;
      case 'gold':
        return const Color(0xFFF9A825);
      case 'lime':
        return AppTheme.secondaryLime;
      case 'orange':
        return AppTheme.statusEnRoute;
      case 'red':
        return AppTheme.error;
      default:
        return AppTheme.primaryGreen;
    }
  }

  static IconData _iconFor(String i) {
    switch (i) {
      case 'recycling_rounded':
        return Icons.recycling_rounded;
      case 'emoji_events_rounded':
        return Icons.emoji_events_rounded;
      case 'grass_rounded':
        return Icons.grass_rounded;
      case 'delete_outline_rounded':
        return Icons.delete_outline_rounded;
      case 'local_fire_department_rounded':
        return Icons.local_fire_department_rounded;
      case 'cancel_outlined':
        return Icons.cancel_outlined;
      default:
        return Icons.stars_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Points Activity',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppTheme.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: AppTheme.surface,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(13),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: _activityMaps.asMap().entries.map((entry) {
              final i = entry.key;
              final activity = entry.value;
              final color = _colorFor(activity['color'] as String);
              final icon = _iconFor(activity['icon'] as String);
              final points = activity['points'] as int;
              final isPositive = activity['positive'] as bool;
              final isLast = i == _activityMaps.length - 1;

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            color: color.withAlpha(26),
                            borderRadius: BorderRadius.circular(11),
                          ),
                          child: Icon(icon, size: 18, color: color),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                activity['action'] as String,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                activity['date'] as String,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 11,
                                  color: AppTheme.textMuted,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '${isPositive ? '+' : ''}$points pts',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: isPositive
                                ? AppTheme.primaryGreen
                                : AppTheme.error,
                            fontFeatures: [const FontFeature.tabularFigures()],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (!isLast)
                    Divider(
                      height: 1,
                      indent: 66,
                      endIndent: 16,
                      color: AppTheme.textMuted.withAlpha(26),
                    ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
