import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/favorites_cubit.dart';
import '../widgets/movie_card/movie_card.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/empty_state.dart';
import '../constants/app_constants.dart';
import '../constants/app_colors.dart';
import '../models/movie.dart';

/// Favorites Page - Shows user's favorite movies
/// Uses FavoritesCubit to manage favorites state
class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  void initState() {
    super.initState();
    context.read<FavoritesCubit>().loadFavorites();
  }

  Future<void> _removeFavorite(Movie movie) async {
    await context.read<FavoritesCubit>().removeFavorite(movie.id);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${movie.title} removed from favorites'),
          duration: const Duration(
            seconds: AppConstants.snackbarDurationSeconds,
          ),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () async {
              await context.read<FavoritesCubit>().addFavorite(movie);
            },
          ),
        ),
      );
    }
  }

  /// Show dialog to clear all favorites
  Future<void> _showClearAllDialog() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All Favorites?'),
        content: const Text(
          'Are you sure you want to remove all movies from favorites?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: AppColors.errorColor),
            child: const Text('Clear All'),
          ),
        ],
      ),
    );

    if (result == true && mounted) {
      final state = context.read<FavoritesCubit>().state;
      if (state is FavoritesLoaded) {
        for (final movie in state.favorites) {
          await context.read<FavoritesCubit>().removeFavorite(movie.id);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: _showClearAllDialog,
          ),
        ],
      ),
      body: BlocBuilder<FavoritesCubit, FavoritesState>(
        builder: (context, state) {
          if (state is FavoritesLoading || state is FavoritesInitial) {
            return const LoadingIndicator(message: 'Loading favorites...');
          }

          if (state is FavoritesError) {
            return ErrorDisplay(
              message: state.message,
              onRetry: () {
                context.read<FavoritesCubit>().loadFavorites();
              },
            );
          }

          if (state is FavoritesLoaded) {
            final favorites = state.favorites;

            if (favorites.isEmpty) {
              return const EmptyState(
                message:
                    'No favorites yet!\n'
                    'Start adding movies to your favorites.',
                icon: Icons.favorite_border,
              );
            }

            return ListView.builder(
              itemCount: favorites.length,
              padding: const EdgeInsets.all(AppConstants.paddingMedium),
              itemBuilder: (context, index) {
                final movie = favorites[index];

                return MovieCard(
                  movie: movie,
                  isFavorite: true,
                  onFavoriteToggle: () => _removeFavorite(movie),
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
