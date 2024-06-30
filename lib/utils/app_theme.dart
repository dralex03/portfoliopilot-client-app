import 'package:flutter/material.dart';

class AppColors{
  static const Color backgroundColor = Color(0xFF2D3748);
  static const Color indicatorColor = Color(0xFF252E3C);
  static const Color navigationBarColor = Color(0xFF2D3748);

  static const Color gradientColor = Color(0xFFF7F7FF);
  static const Color assetListColor = Color(0xFF1A202C);
  static const Color assetItemColor = Color(0xFF2D3748);

  static const Color positiveColor = Color(0xFF33D49D);
  static const Color negativeColor = Color(0xFFD4333D);


  static const Gradient neutralGradient = LinearGradient(
      colors: [
        backgroundColor,
        indicatorColor,
      ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient positiveGradient = LinearGradient(
    colors: [
      positiveColor,
      indicatorColor,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static const LinearGradient negativeGradient = LinearGradient(
    colors: [
      negativeColor,
      indicatorColor,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

class AppTextThemes {
  static TextTheme textTheme = const TextTheme(
    bodyLarge: TextStyle(fontFamily: 'Lato', fontSize: 20),
    bodyMedium: TextStyle(fontFamily: 'Lato', fontSize: 18),
    displayMedium: TextStyle(fontFamily: 'Lato', fontSize: 24, fontWeight: FontWeight.bold),
    displayLarge: TextStyle(fontFamily: 'Lato', fontSize: 32, fontWeight: FontWeight.bold),
  );
}

class AppTheme {
  static final ThemeData themeData = ThemeData(
    primaryColor: AppColors.backgroundColor,
    scaffoldBackgroundColor: AppColors.backgroundColor,
    fontFamily: 'Lato',
    textTheme: AppTextThemes.textTheme,
  );
}