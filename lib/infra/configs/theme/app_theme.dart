import 'package:flutter/material.dart';

import '../config_exports.dart';

class AppTheme {
  static final appTheme = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    brightness: Brightness.light,
    fontFamily: 'Poppins',
    
    // Card Theme
    cardTheme: CardTheme(
      color: AppColors.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      shadowColor: AppColors.shadowLight,
    ),
    
    // AppBar Theme
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColors.white),
      titleTextStyle: TextStyle(
        color: AppColors.white,
        fontSize: 18,
        fontWeight: FontWeight.w500,
        fontFamily: 'Poppins',
      ),
    ),
    
    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      ),
    ),
    
    // Text Theme
    textTheme: const TextTheme(

      // Headline Text Styles
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        fontFamily: 'Poppins',
      ),
      headlineMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        fontFamily: 'Poppins',
      ),
      headlineSmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        fontFamily: 'Poppins',
      ),

      // Title Text Styles
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        fontFamily: 'Poppins',
      ),
      titleMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
        fontFamily: 'Poppins',
      ),
      titleSmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
        fontFamily: 'Poppins',
      ),


      // Body Text Styles
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
        fontFamily: 'Poppins',
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
        fontFamily: 'Poppins',
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.textLight,
        fontFamily: 'Poppins',
      ),



    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.primary),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.error),
      ),
      hintStyle: const TextStyle(
        color: AppColors.textLight,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}