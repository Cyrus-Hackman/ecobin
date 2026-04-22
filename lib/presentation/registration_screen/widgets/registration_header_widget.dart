import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../theme/app_theme.dart';

class RegistrationHeaderWidget extends StatelessWidget {
  final VoidCallback onBack;

  const RegistrationHeaderWidget({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1B5E20), AppTheme.primaryGreen],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: onBack,
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 22,
            ),
            style: IconButton.styleFrom(
              backgroundColor: Colors.white.withAlpha(38),
              padding: const EdgeInsets.all(8),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Create Account',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Join EcoBin and start collecting eco-points',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              color: Colors.white.withAlpha(217),
            ),
          ),
        ],
      ),
    );
  }
}
