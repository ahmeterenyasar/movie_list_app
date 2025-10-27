import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key, required this.message, this.icon});

  final String message;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon ?? Icons.movie_filter_outlined,
            size: AppConstants.iconSizeXXLarge,
            color: AppColors.grey400,
          ),
          const SizedBox(height: AppConstants.paddingXLarge),
          Text(
            message,
            style: AppTextStyles.heading(context),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
