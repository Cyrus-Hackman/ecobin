import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../theme/app_theme.dart';

class EcoPointsHeroWidget extends StatefulWidget {
  const EcoPointsHeroWidget({super.key});

  @override
  State<EcoPointsHeroWidget> createState() => _EcoPointsHeroWidgetState();
}

class _EcoPointsHeroWidgetState extends State<EcoPointsHeroWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;

  // Points data: current = 2840, next tier at 4000
  static const int _currentPoints = 2840;
  static const int _nextTierPoints = 4000;
  static const int _tierStartPoints = 1000;

  double get _tierProgress =>
      (_currentPoints - _tierStartPoints) /
      (_nextTierPoints - _tierStartPoints);

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _progressAnimation = Tween<double>(begin: 0.0, end: _tierProgress).animate(
      CurvedAnimation(parent: _progressController, curve: Curves.easeOutCubic),
    );
    _progressController.forward();
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  // Weekly points history for chart
  static const List<double> _weeklyPoints = [180, 90, 210, 120, 300, 160, 240];
  static const List<String> _weekDays = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1B5E20), AppTheme.primaryGreen, Color(0xFF558B2F)],
          stops: [0.0, 0.55, 1.0],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryGreen.withAlpha(102),
            blurRadius: 28,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(51),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('🌱', style: TextStyle(fontSize: 14)),
                          const SizedBox(width: 5),
                          Text(
                            'Sapling Tier',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '$_currentPoints',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 48,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        fontFeatures: [const FontFeature.tabularFigures()],
                        height: 1.0,
                      ),
                    ),
                    Text(
                      'Eco Points',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        color: Colors.white.withAlpha(217),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 130,
                height: 90,
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: 350,
                    barTouchData: BarTouchData(enabled: false),
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            final idx = value.toInt();
                            if (idx < 0 || idx >= _weekDays.length) {
                              return const SizedBox.shrink();
                            }
                            return Text(
                              _weekDays[idx][0],
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 9,
                                color: Colors.white.withAlpha(179),
                              ),
                            );
                          },
                          reservedSize: 16,
                        ),
                      ),
                      leftTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    gridData: const FlGridData(show: false),
                    borderData: FlBorderData(show: false),
                    barGroups: _weeklyPoints.asMap().entries.map((e) {
                      final isCurrent = e.key == 6;
                      return BarChartGroupData(
                        x: e.key,
                        barRods: [
                          BarChartRodData(
                            toY: e.value,
                            color: isCurrent
                                ? Colors.white
                                : Colors.white.withAlpha(115),
                            width: 10,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(4),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Progress to Tree Tier 🌳',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white.withAlpha(230),
                ),
              ),
              Text(
                '${_nextTierPoints - _currentPoints} pts to go',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  color: Colors.white.withAlpha(191),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          AnimatedBuilder(
            animation: _progressAnimation,
            builder: (_, __) => ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: _progressAnimation.value,
                backgroundColor: Colors.white.withAlpha(51),
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                minHeight: 10,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$_tierStartPoints pts',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 10,
                  color: Colors.white.withAlpha(153),
                ),
              ),
              Text(
                '$_nextTierPoints pts',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 10,
                  color: Colors.white.withAlpha(153),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
