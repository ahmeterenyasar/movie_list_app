import 'package:flutter/material.dart';
import '../../../constants/app_constants.dart';
import '../../../constants/app_text_styles.dart';
import '../../../constants/app_colors.dart';
import '../../../models/movie.dart';

class MovieDetails extends StatelessWidget {
  const MovieDetails({
    super.key,
    required this.movie,
    required this.isFavorite,
    required this.onFavoriteToggle,
  });

  final Movie movie;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.paddingLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitleAndFavorite(context),
          const SizedBox(height: AppConstants.paddingSmall),
          _buildRating(context),
          const SizedBox(height: AppConstants.paddingMedium),
          _buildOverview(context),
          const SizedBox(height: AppConstants.paddingSmall),
          _buildReleaseDate(context),
        ],
      ),
    );
  }

  Widget _buildTitleAndFavorite(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            movie.title,
            style: AppTextStyles.title(context),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        IconButton(
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite
                ? AppColors.favoriteActive
                : AppColors.favoriteInactive,
          ),
          onPressed: onFavoriteToggle,
        ),
      ],
    );
  }

  Widget _buildRating(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.star,
          color: AppColors.starColor,
          size: AppConstants.iconSizeSmall,
        ),
        const SizedBox(width: AppConstants.paddingSmall),
        Text(
          movie.voteAverage.toStringAsFixed(1),
          style: AppTextStyles.caption(context),
        ),
      ],
    );
  }

  Widget _buildOverview(BuildContext context) {
    return Text(
      movie.overview ?? 'No overview available',
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: AppTextStyles.smallText(context),
    );
  }

  Widget _buildReleaseDate(BuildContext context) {
    return Text(
      movie.releaseDate ?? 'Release date unknown',
      style: AppTextStyles.tinyText(context),
    );
  }
}
