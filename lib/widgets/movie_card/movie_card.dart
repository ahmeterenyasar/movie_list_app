import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';
import '../../models/movie.dart';
import 'components/movie_poster.dart';
import 'components/movie_details.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({
    super.key,
    required this.movie,
    required this.onFavoriteToggle,
    required this.isFavorite,
    this.onTap,
  });

  final Movie movie;
  final VoidCallback onFavoriteToggle;
  final bool isFavorite;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(AppConstants.paddingMedium),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MoviePoster(movie: movie),
            MovieDetails(
              movie: movie,
              isFavorite: isFavorite,
              onFavoriteToggle: onFavoriteToggle,
            ),
          ],
        ),
      ),
    );
  }
}
