import 'package:flutter/material.dart';

class AppColors {
  // Primary colors
  static const primaryDark = Color(0xFF0A1747);  // Navy blue for nav bars
  static const primaryMedium = Color(0xFF4793B8);  // Teal for buttons and cards
  static const primaryLight = Color(0xFFE8F2F6);  // Light blue/gray for backgrounds

  // Secondary colors
  static const accent = Color(0xFF4265D6);  // Blue gradient for branding
  static const white = Colors.white;
  static const black = Colors.black;
  static const gray = Color(0xFFE8E8E8);
  static const textGray = Color(0xFF8F8F8F);
}

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.primaryLight,
    primaryColor: AppColors.primaryDark,
    colorScheme: ColorScheme.light(
      primary: AppColors.primaryDark,
      secondary: AppColors.primaryMedium,
      surface: AppColors.white,
      background: AppColors.primaryLight,
      error: Colors.red,
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primaryDark,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppColors.white,
      ),
      iconTheme: IconThemeData(
        color: AppColors.white,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryDark,
        foregroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),

    cardTheme: CardTheme(
      color: AppColors.primaryMedium,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    ),

    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryDark,
      ),
      displayMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryDark,
      ),
      displaySmall: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryDark,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: AppColors.black,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: AppColors.black,
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
      hintStyle: TextStyle(color: AppColors.textGray),
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.primaryDark,
      selectedItemColor: AppColors.white,
      unselectedItemColor: AppColors.primaryMedium.withOpacity(0.7),
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),
  );
}