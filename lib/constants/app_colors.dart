import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary Colors
  static const Color primaryColor = Color.fromARGB(255, 32, 44, 113);
  static const Color errorColor = Colors.red;

  // Grey Shades (for text and borders)
  static Color grey300 = Colors.grey[300]!;
  static Color grey400 = Colors.grey[400]!;
  static Color grey500 = Colors.grey[500]!;
  static Color grey600 = Colors.grey[600]!;
  static Color grey700 = Colors.grey[700]!;

  // Theme Colors
  static Color get favoriteActive => Colors.red;
  static Color get favoriteInactive => Colors.grey;
  static Color get starColor => Colors.amber;
  static Color get errorIcon => Colors.red[300]!;
}
