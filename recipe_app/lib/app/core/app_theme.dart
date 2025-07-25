import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xFFCEA700); 
  static const Color textColor = Color(0xFF212121);
  static const Color backgroundColor = Color(0xFFF8F8F8);
}

class AppTextStyles {
  static const TextStyle titleLarge = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textColor,
  );

  static const TextStyle titleMedium = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: AppColors.textColor,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 16,
    color: AppColors.textColor,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 14,
    color: Colors.grey,
  );
}

class AppSizes {
  static const double paddingSmall = 8;
  static const double paddingMedium = 16;
  static const double paddingLarge = 24;

  static const double borderRadiusSmall = 8;
  static const double borderRadiusMedium = 16;
}