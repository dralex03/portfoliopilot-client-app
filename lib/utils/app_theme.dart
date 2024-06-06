import 'package:flutter/material.dart';

class AppColors{
  static const Color backgroundColor = Color(0xFF2D3748);
  static const Color indicatorColor = Color(0xFF252E3C);
  static const Color gradientColor = Color(0xFFF7F7FF);

}

class AppTextThemes {
  static TextTheme textTheme = const TextTheme(
    bodyLarge: TextStyle(fontFamily: 'Montserrat', fontSize: 20),
    bodyMedium: TextStyle(fontFamily: 'Montserrat', fontSize: 18),
    displayLarge: TextStyle(fontFamily: 'Montserrat', fontSize: 32, fontWeight: FontWeight.bold),
    displayMedium: TextStyle(fontFamily: 'Montserrat', fontSize: 24, fontWeight: FontWeight.bold),
    // Füge weitere Textstile nach Bedarf hinzu
  );
}

class AppTheme {
  static final ThemeData themeData = ThemeData(
    primaryColor: AppColors.backgroundColor,
    scaffoldBackgroundColor: AppColors.backgroundColor,
    fontFamily: 'Montserrat',
    textTheme: AppTextThemes.textTheme,
  );
}