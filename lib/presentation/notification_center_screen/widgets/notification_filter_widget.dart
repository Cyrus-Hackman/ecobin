import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../theme/app_theme.dart';

class NotificationFilterWidget extends StatelessWidget {
  final List<String> filters;
  final String selectedFilter;
  final int unreadCount;
  final ValueChanged<String> onFilterSelected;
  final bool vertical;

  const NotificationFilterWidget({
    super.key,
    required this.filters,
    required this.selectedFilter,
    required this.unreadCount,
    required this.onFilterSelected,
    this.vertical = false,
  });

  @override
  Widget build(BuildContext context) {
    if (vertical) {
      return Container(
        color: AppTheme.surface,
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Filter',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppTheme.textMuted,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 12),
            ...filters.map((f) {
              final isSelected = f == selectedFilter;
              return GestureDetector(
                onTap: () => onFilterSelected(f),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 11,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppTheme.primaryGreen.withAlpha(26)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                    border: isSelected
                        ? Border.all(color: AppTheme.primaryGreen.withAlpha(77))
                        : null,
                  ),
                  child: Row(
                    children: [
                      Text(
                        f,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: isSelected
                              ? FontWeight.w700
                              : FontWeight.w400,
                          color: isSelected
                              ? AppTheme.primaryGreen
                              : AppTheme.textSecondary,
                        ),
                      ),
                      if (f == 'All' && unreadCount > 0) ...[
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 7,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.error,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '$unreadCount',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      );
    }

    return Container(
      color: AppTheme.surface,
      padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: filters.map((f) {
            final isSelected = f == selectedFilter;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: GestureDetector(
                onTap: () => onFilterSelected(f),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppTheme.primaryGreen
                        : AppTheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        f,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: isSelected
                              ? Colors.white
                              : AppTheme.textSecondary,
                        ),
                      ),
                      if (f == 'All' && unreadCount > 0) ...[
                        const SizedBox(width: 6),
                        Container(
                          width: 18,
                          height: 18,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.white.withAlpha(77)
                                : AppTheme.error,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '$unreadCount',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
