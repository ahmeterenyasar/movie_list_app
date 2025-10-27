import 'package:flutter/material.dart';
import '../../../constants/app_constants.dart';
import '../../../constants/app_colors.dart';
import '../../../models/movie.dart';

class MoviePoster extends StatelessWidget {
  const MoviePoster({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(AppConstants.borderRadiusMedium),
      ),
      child: SizedBox(
        height: AppConstants.movieCardHeight,
        width: double.infinity,
        child: _buildImage(),
      ),
    );
  }

  Widget _buildImage() {
    if (movie.posterPath != null &&
        movie.posterPath != 'null' &&
        movie.posterPath!.isNotEmpty) {
      return Image.network(
        movie.fullImageUrl!,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
      );
    }
    return _buildPlaceholder();
  }

  Widget _buildPlaceholder() {
    return Container(
      color: AppColors.grey300,
      child: Icon(
        Icons.movie_outlined,
        size: AppConstants.iconSizeXLarge,
        color: AppColors.grey500,
      ),
    );
  }
}
