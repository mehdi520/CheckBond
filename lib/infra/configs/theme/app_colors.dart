import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF1976D2);
  static const Color primaryLight = Color(0xFF64B5F6);
  static const Color primaryDark = Color(0xFF0D47A1);

  // Secondary Colors
  static const Color secondary900 = Color(0xFF1F2937);
  static const Color secondary800 = Color(0xFF374151);
  static const Color secondary700 = Color(0xFF4B5563);
  static const Color secondary600 = Color(0xFF6B7280);
  static const Color secondary500 = Color(0xFF9CA3AF);
  static const Color secondary400 = Color(0xFFD1D5DB);
  static const Color secondary300 = Color(0xFFE5E7EB);
  static const Color secondary200 = Color(0xFFF3F4F6);
  static const Color secondary100 = Color(0xFFF9FAFB);
  static const Color secondary50 = Color(0xFFFAFAFA);

  // Status Colors
  static const Color success = Color(0xFF16A34A);
  static const Color successLight = Color(0xFFDCFCE7);
  static const Color warning = Color(0xFFF97316);
  static const Color warningLight = Color(0xFFFFF8E1);
  static const Color error = Color(0xFFDC2626);
  static const Color errorLight = Color(0xFFFEE2E2);
  static const Color info = Color(0xFF2196F3);
  static const Color infoLight = Color(0xFFE3F2FD);

  // Background Colors
  static const Color background = Color(0xFFF8FAFC);
  static const Color surface = Colors.white;
  static const Color surfaceLight = Color(0xFFF9FAFB);
  static const Color white = Colors.white;

  // Border Colors
  static const Color border = Color(0xFFE5E7EB);
  static const Color borderLight = Color(0xFFF3F4F6);
  static const Color secondBackground = Color(0xFFE5E7EB);

  // Shadow Colors
  static final Color shadowLight = Colors.black.withOpacity(0.04);
  static final Color shadowMedium = Colors.black.withOpacity(0.12);

  // Card Shadow
  static List<BoxShadow> cardShadow = [
    BoxShadow(
      color: shadowLight,
      offset: const Offset(0, 1),
      blurRadius: 3,
    ),
    BoxShadow(
      color: shadowMedium,
      offset: const Offset(0, 2),
      blurRadius: 8,
    ),
  ];
  

  // Text Colors
  static const Color textPrimary = secondary900;
  static const Color textSecondary = secondary600;
  static const Color textLight = secondary500;
  static const Color textDisabled = secondary400;
}