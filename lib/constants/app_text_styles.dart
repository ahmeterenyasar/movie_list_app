import 'package:flutter/material.dart';
import 'app_constants.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle title(BuildContext context) {
    return const TextStyle(
      fontSize: AppConstants.textSizeTitle,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle body(BuildContext context) {
    return TextStyle(
      color: AppColors.grey700,
      fontSize: AppConstants.textSizeBody,
    );
  }

  static TextStyle caption(BuildContext context) {
    return TextStyle(
      color: AppColors.grey600,
      fontSize: AppConstants.textSizeBody,
    );
  }

  static TextStyle smallText(BuildContext context) {
    return TextStyle(
      color: AppColors.grey700,
      fontSize: AppConstants.textSizeMedium,
    );
  }

  static TextStyle tinyText(BuildContext context) {
    return TextStyle(
      color: AppColors.grey500,
      fontSize: AppConstants.textSizeSmall,
    );
  }

  static TextStyle heading(BuildContext context) {
    return TextStyle(
      fontSize: AppConstants.textSizeHeading,
      fontWeight: FontWeight.w500,
      color: AppColors.grey600,
    );
  }

  static TextStyle errorMessage(BuildContext context) {
    return const TextStyle(
      fontSize: AppConstants.textSizeTitle,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle loadingMessage(BuildContext context) {
    return TextStyle(color: AppColors.grey600);
  }
}
