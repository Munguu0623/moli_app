// lib/ui/design_system.dart
import 'package:flutter/material.dart';

class AppColors {
  // Modern vibrant brand colors
  static const primary = Color(0xFF6F63F7); // Indigo
  static const primary2 = Color(0xFF9D5CFF); // Purple
  static const accent = Color(0xFFF59E0B); // Amber
  static const success = Color(0xFF10B981); // Emerald
  static const error = Color(0xFFEF4444); // Red
  static const warning = Color(0xFFF59E0B); // Amber/Orange
  static const info = Color(0xFF3B82F6); // Blue

  // Neutrals - зөөлөн бөгөөд уншигдах чадвартай
  static const textPrimary = Color(0xFF1F2937); // gray-800 - зөөлөн бараан
  static const textSecondary = Color(0xFF6B7280); // gray-500
  static const textTertiary = Color(0xFF9CA3AF); // gray-400
  static const surface = Colors.white;
  static const background = Color(0xFFF9FAFB);
  static const border = Color(0xFFE5E7EB);

  // Vibrant chips - илүү тодорхой өнгөтэй пастель
  static const chipBlue = Color(0xFFDDD6FE); // Лаванда
  static const chipPurple = Color(0xFFE9D5FF); // Ягаан пастель
  static const chipOrange = Color(0xFFFFDDB3); // Алтан шар
  static const chipGreen = Color(0xFFBFEFD5); // Минт ногоон
  static const chipPink = Color(0xFFFFDAE9); // Ягаан бараан
}

class AppGradients {
  static const brand = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF6F63F7), Color(0xFF9D5CFF)],
  );

  static const brandAlt = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
  );

  static const success = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF10B981), Color(0xFF059669)],
  );

  static const accent = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFF59E0B), Color(0xFFEF4444)],
  );

  // Glassmorphism background
  static const glass = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0x40FFFFFF), Color(0x20FFFFFF)],
  );
}

class AppRadius {
  static const card = 16.0; // ✅ UX-тэй нийцнэ
  static const cardCompact = 12.0; // list cards-д
  static const cardLarge = 20.0; // hero elements
  static const button = 16.0;
  static const chip = 16.0;
  static const small = 8.0;
}

class AppShadows {
  // Layered, softer shadows для глубины
  static List<BoxShadow> card = const [
    BoxShadow(
      color: Color(0x0A000000),
      blurRadius: 20,
      offset: Offset(0, 4),
      spreadRadius: 0,
    ),
  ];

  static List<BoxShadow> cardHover = const [
    BoxShadow(
      color: Color(0x12000000),
      blurRadius: 28,
      offset: Offset(0, 8),
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Color(0x08000000),
      blurRadius: 48,
      offset: Offset(0, 12),
      spreadRadius: 0,
    ),
  ];

  static List<BoxShadow> button = const [
    BoxShadow(
      color: Color(0x15000000),
      blurRadius: 12,
      offset: Offset(0, 4),
      spreadRadius: 0,
    ),
  ];

  static List<BoxShadow> glow = [
    BoxShadow(
      color: AppColors.primary.withOpacity(0.3),
      blurRadius: 24,
      offset: const Offset(0, 8),
      spreadRadius: 0,
    ),
  ];
}

class AppText {
  static TextTheme textTheme = const TextTheme(
    displaySmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
    titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
    bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
    labelLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    labelMedium: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
  ).apply(
    bodyColor: AppColors.textPrimary,
    displayColor: AppColors.textPrimary,
  );
}

class AppSizes {
  static const avatarSmall = 24.0;
  static const avatarMedium = 32.0;
  static const avatarLarge = 48.0;
}

ThemeData buildAppTheme() {
  final base = ThemeData(
    useMaterial3: true,
    // Default system font-ыг ашиглах
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      secondary: AppColors.primary2,
      surface: AppColors.surface,
      background: AppColors.background,
      error: AppColors.error,
    ),
    textTheme: AppText.textTheme,
  );

  return base.copyWith(
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.surface,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w900,
        color: AppColors.textPrimary,
        letterSpacing: 0.2,
      ),
      iconTheme: const IconThemeData(color: AppColors.textPrimary, size: 24),
      shadowColor: AppColors.primary.withOpacity(0.05),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textTertiary,
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 11),
      unselectedLabelStyle: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 10,
      ),
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      backgroundColor: AppColors.background,
      selectedIconTheme: IconThemeData(size: 26, weight: 600, opticalSize: 20),
      unselectedIconTheme: IconThemeData(
        size: 24,
        weight: 300,
        opticalSize: 20,
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.chipBlue,
      selectedColor: AppColors.primary,
      labelStyle: const TextStyle(
        fontSize: 14,
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w600,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.chip),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  );
}
