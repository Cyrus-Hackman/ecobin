import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../theme/app_theme.dart';

class MarketplaceRewardItem {
  final String id;
  final String title;
  final String vendor;
  final String description;
  final int pointsCost;
  final String category;
  final String imageUrl;
  final String tag;
  final Color tagColor;
  final bool isAvailable;

  const MarketplaceRewardItem({
    required this.id,
    required this.title,
    required this.vendor,
    required this.description,
    required this.pointsCost,
    required this.category,
    required this.imageUrl,
    required this.tag,
    required this.tagColor,
    required this.isAvailable,
  });
}

class MarketplaceRewardCardWidget extends StatelessWidget {
  final MarketplaceRewardItem item;
  final int userPoints;
  final VoidCallback onRedeem;

  const MarketplaceRewardCardWidget({
    super.key,
    required this.item,
    required this.userPoints,
    required this.onRedeem,
  });

  bool get _canAfford => userPoints >= item.pointsCost;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(12),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image section
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: Image.network(
                  item.imageUrl,
                  height: 110,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  semanticLabel: item.title,
                  errorBuilder: (_, __, ___) => Container(
                    height: 110,
                    color: AppTheme.surfaceVariant,
                    child: const Icon(
                      Icons.image_outlined,
                      color: AppTheme.textMuted,
                      size: 32,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: item.tagColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    item.tag,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              if (!item.isAvailable)
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    child: Container(
                      color: Colors.black.withAlpha(100),
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(160),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Sold Out',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  item.vendor,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.textMuted,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Text(
                  item.description,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: AppTheme.textSecondary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          const Icon(
                            Icons.eco_rounded,
                            size: 14,
                            color: AppTheme.primaryGreen,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${item.pointsCost} pts',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                              color: AppTheme.primaryGreen,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: (item.isAvailable && _canAfford) ? onRedeem : null,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: (item.isAvailable && _canAfford)
                              ? AppTheme.primaryGreen
                              : const Color(0xFFE0E0E0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          item.isAvailable
                              ? (_canAfford ? 'Redeem' : 'Need more')
                              : 'Sold Out',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: (item.isAvailable && _canAfford)
                                ? Colors.white
                                : AppTheme.textMuted,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
