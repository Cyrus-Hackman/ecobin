import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../theme/app_theme.dart';

class EcoBadgesWidget extends StatelessWidget {
  const EcoBadgesWidget({super.key});

  static final List<Map<String, dynamic>> _badgeMaps = [
    {
      'id': 'b1',
      'title': 'First Pickup',
      'emoji': '🗑️',
      'description': 'Completed your first collection',
      'unlocked': true,
      'unlockedDate': 'Mar 2, 2026',
      'color': 'green',
    },
    {
      'id': 'b2',
      'title': 'Recycling Hero',
      'emoji': '♻️',
      'description': '10 recycling pickups completed',
      'unlocked': true,
      'unlockedDate': 'Apr 14, 2026',
      'color': 'blue',
    },
    {
      'id': 'b3',
      'title': 'Green Streak',
      'emoji': '🔥',
      'description': '4 weeks in a row',
      'unlocked': true,
      'unlockedDate': 'Apr 10, 2026',
      'color': 'orange',
    },
    {
      'id': 'b4',
      'title': 'Yard Champion',
      'emoji': '🌿',
      'description': '5 yard waste pickups',
      'unlocked': false,
      'unlockedDate': '',
      'color': 'lime',
    },
    {
      'id': 'b5',
      'title': 'Tree Hugger',
      'emoji': '🌳',
      'description': 'Reach Tree Tier (4,000 pts)',
      'unlocked': false,
      'unlockedDate': '',
      'color': 'green',
    },
    {
      'id': 'b6',
      'title': 'Zero Waste Week',
      'emoji': '🏆',
      'description': 'Complete all waste types in one week',
      'unlocked': false,
      'unlockedDate': '',
      'color': 'gold',
    },
  ];

  static Color _colorFor(String c) {
    switch (c) {
      case 'blue':
        return AppTheme.info;
      case 'orange':
        return AppTheme.statusEnRoute;
      case 'lime':
        return AppTheme.secondaryLime;
      case 'gold':
        return const Color(0xFFF9A825);
      default:
        return AppTheme.primaryGreen;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= 600;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Badges',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppTheme.textPrimary,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppTheme.primaryGreen.withAlpha(26),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '3 / 6 unlocked',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.primaryGreen,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isTablet ? 3 : 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.1,
          ),
          itemCount: _badgeMaps.length,
          itemBuilder: (context, index) {
            final badge = _badgeMaps[index];
            final unlocked = badge['unlocked'] as bool;
            final color = _colorFor(badge['color'] as String);
            return _BadgeCard(badge: badge, unlocked: unlocked, color: color);
          },
        ),
      ],
    );
  }
}

class _BadgeCard extends StatelessWidget {
  final Map<String, dynamic> badge;
  final bool unlocked;
  final Color color;

  const _BadgeCard({
    required this.badge,
    required this.unlocked,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: unlocked ? color.withAlpha(15) : AppTheme.surfaceVariant,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: unlocked
              ? color.withAlpha(64)
              : AppTheme.textMuted.withAlpha(38),
          width: 1.5,
        ),
        boxShadow: unlocked
            ? [
                BoxShadow(
                  color: color.withAlpha(31),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ]
            : [],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Text(
                badge['emoji'] as String,
                style: TextStyle(
                  fontSize: 32,
                  color: unlocked ? null : Colors.transparent,
                ),
              ),
              if (!unlocked)
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppTheme.textMuted.withAlpha(26),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.lock_outline_rounded,
                    size: 20,
                    color: AppTheme.textMuted,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            badge['title'] as String,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: unlocked ? AppTheme.textPrimary : AppTheme.textMuted,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 3),
          Text(
            unlocked
                ? (badge['unlockedDate'] as String)
                : (badge['description'] as String),
            style: GoogleFonts.plusJakartaSans(
              fontSize: 10,
              color: unlocked ? color : AppTheme.textMuted,
              fontWeight: unlocked ? FontWeight.w500 : FontWeight.w400,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
