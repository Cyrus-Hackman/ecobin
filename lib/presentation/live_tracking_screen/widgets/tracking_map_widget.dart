import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../theme/app_theme.dart';

class TrackingMapWidget extends StatefulWidget {
  const TrackingMapWidget({super.key});

  @override
  State<TrackingMapWidget> createState() => _TrackingMapWidgetState();
}

class _TrackingMapWidgetState extends State<TrackingMapWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _truckController;
  late Animation<double> _truckAnimation;

  @override
  void initState() {
    super.initState();
    _truckController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat(reverse: true);
    _truckAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _truckController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _truckController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final topPad = MediaQuery.of(context).padding.top + 56;
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: const Color(0xFFE8F0E8),
      child: Stack(
        children: [
          // Map background simulation
          CustomPaint(painter: _MapBackgroundPainter(), child: Container()),
          // Road network lines
          CustomPaint(painter: _RoadPainter(), child: Container()),
          // Animated truck marker
          AnimatedBuilder(
            animation: _truckAnimation,
            builder: (context, _) {
              final screenW = MediaQuery.of(context).size.width;
              final screenH = MediaQuery.of(context).size.height;
              final tx =
                  screenW * 0.25 + (screenW * 0.35 * _truckAnimation.value);
              final ty =
                  screenH * 0.35 + (screenH * 0.08 * _truckAnimation.value);
              return Positioned(
                left: tx - 22,
                top: ty - 22,
                child: _TruckMarker(),
              );
            },
          ),
          // User location pin
          Positioned(
            left: MediaQuery.of(context).size.width * 0.55,
            top: MediaQuery.of(context).size.height * 0.52,
            child: _UserLocationPin(),
          ),
          // Map controls
          Positioned(
            right: 16,
            top: topPad + 12,
            child: Column(
              children: [
                _MapControlButton(icon: Icons.add_rounded, onTap: () {}),
                const SizedBox(height: 8),
                _MapControlButton(icon: Icons.remove_rounded, onTap: () {}),
                const SizedBox(height: 8),
                _MapControlButton(
                  icon: Icons.my_location_rounded,
                  onTap: () {},
                ),
              ],
            ),
          ),
          // Route line hint
          CustomPaint(painter: _RoutePainter(), child: Container()),
          // Map attribution
          Positioned(
            bottom: 260,
            right: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(217),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                '© EcoBin Maps Preview',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 10,
                  color: AppTheme.textMuted,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TruckMarker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: AppTheme.primaryGreen,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppTheme.primaryGreen.withAlpha(102),
                blurRadius: 12,
                spreadRadius: 3,
              ),
            ],
          ),
          child: const Icon(
            Icons.local_shipping_rounded,
            color: Colors.white,
            size: 22,
          ),
        ),
        Container(width: 2, height: 8, color: AppTheme.primaryGreen),
        Container(
          width: 8,
          height: 8,
          decoration: const BoxDecoration(
            color: AppTheme.primaryGreen,
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }
}

class _UserLocationPin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: const Color(0xFF0277BD),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 3),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF0277BD).withAlpha(89),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: const Icon(Icons.home_rounded, color: Colors.white, size: 18),
        ),
        Container(width: 2, height: 6, color: const Color(0xFF0277BD)),
        Container(
          width: 6,
          height: 6,
          decoration: const BoxDecoration(
            color: Color(0xFF0277BD),
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }
}

class _MapControlButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _MapControlButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(31),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, size: 20, color: AppTheme.textPrimary),
      ),
    );
  }
}

class _MapBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0xFFE8F0E8);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    // Green park areas
    final parkPaint = Paint()..color = const Color(0xFFD0E8C8);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          size.width * 0.1,
          size.height * 0.15,
          size.width * 0.25,
          size.height * 0.18,
        ),
        const Radius.circular(12),
      ),
      parkPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          size.width * 0.6,
          size.height * 0.55,
          size.width * 0.3,
          size.height * 0.15,
        ),
        const Radius.circular(12),
      ),
      parkPaint,
    );

    // Building blocks
    final buildingPaint = Paint()..color = const Color(0xFFD8E4D8);
    for (int i = 0; i < 5; i++) {
      for (int j = 0; j < 4; j++) {
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(
              size.width * (0.05 + i * 0.2),
              size.height * (0.1 + j * 0.22),
              size.width * 0.1,
              size.height * 0.08,
            ),
            const Radius.circular(4),
          ),
          buildingPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _RoadPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final roadPaint = Paint()
      ..color = const Color(0xFFC8D8C8)
      ..strokeWidth = 16
      ..style = PaintingStyle.stroke;

    // Horizontal roads
    canvas.drawLine(
      Offset(0, size.height * 0.3),
      Offset(size.width, size.height * 0.3),
      roadPaint,
    );
    canvas.drawLine(
      Offset(0, size.height * 0.55),
      Offset(size.width, size.height * 0.55),
      roadPaint,
    );

    // Vertical roads
    canvas.drawLine(
      Offset(size.width * 0.35, 0),
      Offset(size.width * 0.35, size.height),
      roadPaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.65, 0),
      Offset(size.width * 0.65, size.height),
      roadPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _RoutePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final routePaint = Paint()
      ..color = AppTheme.primaryGreen.withAlpha(179)
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path()
      ..moveTo(size.width * 0.3, size.height * 0.38)
      ..lineTo(size.width * 0.35, size.height * 0.38)
      ..lineTo(size.width * 0.35, size.height * 0.55)
      ..lineTo(size.width * 0.55, size.height * 0.55);

    canvas.drawPath(path, routePaint);

    // Dashed overlay
    final dashedPaint = Paint()
      ..color = Colors.white.withAlpha(153)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(path, dashedPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
