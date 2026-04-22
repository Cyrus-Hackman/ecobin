import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Brand Colors
  static const Color primaryGreen = Color(0xFF2D7A2E);
  static const Color primaryLight = Color(0xFF4CAF50);
  static const Color primaryContainer = Color(0xFFE8F5E9);
  static const Color secondaryLime = Color(0xFF8BC34A);
  static const Color earthyBrown = Color(0xFF795548);
  static const Color earthyLight = Color(0xFFA1887F);

  // Semantic Colors
  static const Color success = Color(0xFF2D7A2E);
  static const Color warning = Color(0xFFF57F17);
  static const Color error = Color(0xFFC62828);
  static const Color info = Color(0xFF0277BD);

  // Status Colors
  static const Color statusRequested = Color(0xFF0277BD);
  static const Color statusConfirmed = Color(0xFF6A1B9A);
  static const Color statusEnRoute = Color(0xFFF57F17);
  static const Color statusArrived = Color(0xFF2D7A2E);
  static const Color statusCompleted = Color(0xFF2D7A2E);
  static const Color statusCancelled = Color(0xFFC62828);

  // Surface
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF1F8E9);
  static const Color background = Color(0xFFF8FBF4);
  static const Color onPrimary = Color(0xFFFFFFFF);

  // Text
  static const Color textPrimary = Color(0xFF1B2E1B);
  static const Color textSecondary = Color(0xFF546E54);
  static const Color textMuted = Color(0xFF78909C);

  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.light(
      primary: primaryGreen,
      primaryContainer: primaryContainer,
      secondary: secondaryLime,
      secondaryContainer: Color(0xFFF0F7DA),
      surface: surface,
      surfaceContainerHighest: surfaceVariant,
      error: error,
      onPrimary: onPrimary,
      onSecondary: Color(0xFF1B2E1B),
      onSurface: textPrimary,
      outline: Color(0xFFB0BEC5),
      outlineVariant: Color(0xFFDCE8DC),
    ),
    scaffoldBackgroundColor: background,
    textTheme: GoogleFonts.plusJakartaSansTextTheme(
      const TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: textPrimary,
        ),
        displayMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: textPrimary,
        ),
        headlineLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: textPrimary,
        ),
        headlineMedium: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: textPrimary,
        ),
        headlineSmall: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        titleLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        titleSmall: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        bodyLarge: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: textPrimary,
        ),
        bodyMedium: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: textSecondary,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: textMuted,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.3,
          color: textPrimary,
        ),
        labelSmall: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
          color: textMuted,
        ),
      ),
    ),
    appBarTheme: AppBarThemeData(
      backgroundColor: primaryGreen,
      foregroundColor: onPrimary,
      elevation: 0,
      titleTextStyle: GoogleFonts.plusJakartaSans(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: onPrimary,
      ),
      iconTheme: const IconThemeData(color: onPrimary),
    ),
    cardTheme: CardThemeData(
      color: surface,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: EdgeInsets.zero,
    ),
    inputDecorationTheme: InputDecorationThemeData(
      filled: false,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFB0BEC5), width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFB0BEC5), width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primaryGreen, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: error, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: error, width: 2),
      ),
      labelStyle: GoogleFonts.plusJakartaSans(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppTheme.textMuted,
      ),
      hintStyle: GoogleFonts.plusJakartaSans(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppTheme.textMuted,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      errorStyle: GoogleFonts.plusJakartaSans(fontSize: 12, color: error),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryGreen,
        foregroundColor: onPrimary,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: GoogleFonts.plusJakartaSans(
          fontSize: 15,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: surfaceVariant,
      selectedColor: primaryContainer,
      labelStyle: GoogleFonts.plusJakartaSans(
        fontSize: 13,
        fontWeight: FontWeight.w500,
      ),
      side: const BorderSide(color: Color(0xFFDCE8DC)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Colors.transparent,
      elevation: 0,
      indicatorColor: primaryContainer,
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return GoogleFonts.plusJakartaSans(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: primaryGreen,
          );
        }
        return GoogleFonts.plusJakartaSans(
          fontSize: 11,
          fontWeight: FontWeight.w400,
          color: AppTheme.textMuted,
        );
      }),
    ),
  );

  static ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF66BB6A),
      primaryContainer: Color(0xFF1B3A1C),
      secondary: Color(0xFFAED581),
      surface: Color(0xFF1E2A1E),
      surfaceContainerHighest: Color(0xFF243024),
      error: Color(0xFFEF9A9A),
      onPrimary: Color(0xFF0A1A0A),
      onSurface: Color(0xFFE8F5E9),
      outline: Color(0xFF4A6A4A),
      outlineVariant: Color(0xFF2A3E2A),
    ),
    scaffoldBackgroundColor: const Color(0xFF141E14),
    textTheme: GoogleFonts.plusJakartaSansTextTheme(
      const TextTheme(
        headlineMedium: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: Color(0xFFE8F5E9),
        ),
        titleLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Color(0xFFE8F5E9),
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Color(0xFFE8F5E9),
        ),
        bodyLarge: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: Color(0xFFE8F5E9),
        ),
        bodyMedium: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: Color(0xFFB0C4B0),
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: Color(0xFF78909C),
        ),
      ),
    ),
    appBarTheme: AppBarThemeData(
      backgroundColor: const Color(0xFF1E2A1E),
      foregroundColor: const Color(0xFFE8F5E9),
      elevation: 0,
      titleTextStyle: GoogleFonts.plusJakartaSans(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: const Color(0xFFE8F5E9),
      ),
    ),
  );
}
