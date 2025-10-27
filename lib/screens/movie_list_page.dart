import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/movie_list_cubit.dart';
import '../cubits/favorites_cubit.dart';
import '../widgets/movie_card/movie_card.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/empty_state.dart';
import '../widgets/search_bar_widget.dart';
import '../constants/app_constants.dart';
import '../models/movie.dart';
import 'favorites_page.dart';

class MovieListPage extends StatefulWidget {
  const MovieListPage({super.key});

  @override
  State<MovieListPage> createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  final TextEditingController _searchController = TextEditingController();

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_onScroll);

    context.read<FavoritesCubit>().loadFavorites();
    context.read<MovieListCubit>().loadPopularMovies();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent -
            AppConstants.scrollThreshold) {
      context.read<MovieListCubit>().loadMoreMovies();
    }
  }

  void _onSearchChanged(String query) {
    context.read<MovieListCubit>().searchMovies(query);
  }

  /// Toggle favorite status of a movie
  Future<void> _toggleFavorite(Movie movie, bool isFavorite) async {
    if (isFavorite) {
      // Remove from favorites
      await context.read<FavoritesCubit>().removeFavorite(movie.id);
    } else {
      // Add to favorites
      await context.read<FavoritesCubit>().addFavorite(movie);
    }
  }

  Widget _buildSearchBar() {
    return SearchBarWidget(
      controller: _searchController,
      onChanged: _onSearchChanged,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Movies'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FavoritesPage()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: BlocBuilder<MovieListCubit, MovieListState>(
              builder: (context, state) {

                if (state is MovieListLoading) {
                  return const LoadingIndicator();
                }

                if (state is MovieListError) {
                  return ErrorDisplay(
                    message: state.message,
                    onRetry: () {
                      context.read<MovieListCubit>().loadPopularMovies();
                    },
                  );
                }

                if (state is MovieListLoaded) {
                  final movies = state.movies;

                  if (movies.isEmpty) {
                    return const EmptyState(
                      message: 'No movies found',
                      icon: Icons.search_off,
                    );
                  }

                  return BlocBuilder<FavoritesCubit, FavoritesState>(
                    builder: (context, favoritesState) {
                      return ListView.builder(
                        controller: _scrollController,
                        itemCount: movies.length,
                        padding: const EdgeInsets.all(
                          AppConstants.paddingMedium,
                        ),
                        itemBuilder: (context, index) {
                          final movie = movies[index];

                          final isFavorite = favoritesState is FavoritesLoaded
                              ? favoritesState.favorites.any(
                                  (m) => m.id == movie.id,
                                )
                              : false;

                          return MovieCard(
                            movie: movie,
                            isFavorite: isFavorite,
                            onFavoriteToggle: () =>
                                _toggleFavorite(movie, isFavorite),
                          );
                        },
                      );
                    },
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
