import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../theme/app_theme.dart';

class EcoImpactStatsWidget extends StatelessWidget {
  const EcoImpactStatsWidget({super.key});

  static const List<Map<String, dynamic>> _impactMaps = [
    {
      'label': 'CO₂ Saved',
      'value': '18.4',
      'unit': 'kg',
      'icon': 'cloud_outlined',
      'color': 'blue',
      'delta': '+2.3 kg this month',
    },
    {
      'label': 'Pickups Done',
      'value': '47',
      'unit': 'total',
      'icon': 'task_alt_rounded',
      'color': 'green',
      'delta': '+3 this month',
    },
    {
      'label': 'Recyclables',
      'value': '34.7',
      'unit': 'kg',
      'icon': 'recycling_rounded',
      'color': 'lime',
      'delta': '+5.1 kg this month',
    },
  ];

  // Monthly CO₂ saved data (last 6 months)
  static const List<double> _co2Data = [2.1, 3.4, 2.8, 4.2, 3.1, 2.8];
  static const List<String> _months = [
    'Nov',
    'Dec',
    'Jan',
    'Feb',
    'Mar',
    'Apr',
  ];

  static Color _colorFor(String c) {
    switch (c) {
      case 'blue':
        return AppTheme.info;
      case 'lime':
        return AppTheme.secondaryLime;
      default:
        return AppTheme.primaryGreen;
    }
  }

  static IconData _iconFor(String i) {
    switch (i) {
      case 'cloud_outlined':
        return Icons.cloud_outlined;
      case 'recycling_rounded':
        return Icons.recycling_rounded;
      default:
        return Icons.task_alt_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Environmental Impact',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppTheme.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        ..._impactMaps.map((stat) {
          final color = _colorFor(stat['color'] as String);
          final icon = _iconFor(stat['icon'] as String);
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppTheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border(left: BorderSide(color: color, width: 3)),
              boxShadow: [
                BoxShadow(
                  color: color.withAlpha(20),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
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
                      Text(
                        stat['label'] as String,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          color: AppTheme.textMuted,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        stat['delta'] as String,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11,
                          color: AppTheme.primaryGreen,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      stat['value'] as String,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.textPrimary,
                        fontFeatures: [const FontFeature.tabularFigures()],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 3, left: 3),
                      child: Text(
                        stat['unit'] as String,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          color: AppTheme.textMuted,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
        const SizedBox(height: 16),
        // CO2 Line Chart
        Container(
          padding: const EdgeInsets.all(16),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CO₂ Saved per Month',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Last 6 months (kg)',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 11,
                  color: AppTheme.textMuted,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 120,
                child: LineChart(
                  LineChartData(
                    minY: 0,
                    maxY: 5.5,
                    lineTouchData: LineTouchData(
                      touchTooltipData: LineTouchTooltipData(
                        tooltipBgColor: AppTheme.primaryGreen,
                        getTooltipItems: (spots) => spots
                            .map(
                              (s) => LineTooltipItem(
                                '${s.y.toStringAsFixed(1)} kg',
                                GoogleFonts.plusJakartaSans(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    gridData: FlGridData(
                      drawVerticalLine: false,
                      horizontalInterval: 1,
                      getDrawingHorizontalLine: (_) => FlLine(
                        color: AppTheme.textMuted.withAlpha(26),
                        strokeWidth: 1,
                        dashArray: [4, 4],
                      ),
                    ),
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 22,
                          getTitlesWidget: (value, meta) {
                            final idx = value.toInt();
                            if (idx < 0 || idx >= _months.length) {
                              return const SizedBox.shrink();
                            }
                            return Text(
                              _months[idx],
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 10,
                                color: AppTheme.textMuted,
                              ),
                            );
                          },
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
                    borderData: FlBorderData(show: false),
                    lineBarsData: [
                      LineChartBarData(
                        spots: _co2Data
                            .asMap()
                            .entries
                            .map((e) => FlSpot(e.key.toDouble(), e.value))
                            .toList(),
                        isCurved: true,
                        curveSmoothness: 0.3,
                        color: AppTheme.primaryGreen,
                        barWidth: 2.5,
                        dotData: FlDotData(
                          show: true,
                          getDotPainter: (spot, _, __, ___) =>
                              FlDotCirclePainter(
                                radius: 4,
                                color: AppTheme.primaryGreen,
                                strokeWidth: 2,
                                strokeColor: Colors.white,
                              ),
                        ),
                        belowBarData: BarAreaData(
                          show: true,
                          gradient: LinearGradient(
                            colors: [
                              AppTheme.primaryGreen.withAlpha(51),
                              AppTheme.primaryGreen.withAlpha(0),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}