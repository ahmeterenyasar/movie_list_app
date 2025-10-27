import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../constants/app_text_styles.dart';
import '../constants/app_colors.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key, this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          if (message != null) ...[
            const SizedBox(height: AppConstants.paddingXLarge),
            Text(message!, style: AppTextStyles.loadingMessage(context)),
          ],
        ],
      ),
    );
  }
}

class ErrorDisplay extends StatelessWidget {
  const ErrorDisplay({super.key, required this.message, this.onRetry});

  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.paddingXXXLarge),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: AppConstants.iconSizeXLarge,
              color: AppColors.errorIcon,
            ),
            const SizedBox(height: AppConstants.paddingXLarge),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.errorMessage(context),
            ),
            if (onRetry != null) ...[
              const SizedBox(height: AppConstants.paddingXXLarge),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
