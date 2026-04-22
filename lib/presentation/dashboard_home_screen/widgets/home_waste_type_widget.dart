import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../theme/app_theme.dart';

class HomeWasteTypeWidget extends StatelessWidget {
  final List<String> wasteTypes;
  final String selectedType;
  final ValueChanged<String> onTypeSelected;

  const HomeWasteTypeWidget({
    super.key,
    required this.wasteTypes,
    required this.selectedType,
    required this.onTypeSelected,
  });

  static IconData _iconFor(String type) {
    switch (type) {
      case 'Recycling':
        return Icons.recycling_rounded;
      case 'Yard Waste':
        return Icons.grass_rounded;
      case 'Hazardous':
        return Icons.warning_amber_rounded;
      default:
        return Icons.delete_outline_rounded;
    }
  }

  static Color _colorFor(String type) {
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Waste Type',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppTheme.textPrimary,
          ),
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: wasteTypes.map((type) {
              final isSelected = type == selectedType;
              final color = _colorFor(type);
              final icon = _iconFor(type);
              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOutCubic,
                  child: GestureDetector(
                    onTap: () => onTypeSelected(type),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? color.withAlpha(31)
                            : AppTheme.surface,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: isSelected
                              ? color
                              : AppTheme.textMuted.withAlpha(51),
                          width: isSelected ? 2 : 1,
                        ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: color.withAlpha(51),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ]
                            : [
                                BoxShadow(
                                  color: Colors.black.withAlpha(10),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            icon,
                            size: 18,
                            color: isSelected ? color : AppTheme.textMuted,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            type,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 13,
                              fontWeight: isSelected
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                              color: isSelected
                                  ? color
                                  : AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
