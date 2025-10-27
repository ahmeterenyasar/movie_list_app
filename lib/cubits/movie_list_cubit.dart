import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/movie.dart';
import '../repositories/movie_repository.dart';

/// State class for movie list
/// Uses Equatable for efficient state comparison
abstract class MovieListState extends Equatable {
  const MovieListState();

  @override
  List<Object?> get props => [];
}

class MovieListInitial extends MovieListState {}

class MovieListLoading extends MovieListState {}

class MovieListLoaded extends MovieListState {
  const MovieListLoaded({
    required this.movies,
    required this.page,
    required this.hasReachedMax,
  });

  final List<Movie> movies;
  final int page;
  final bool hasReachedMax;

  @override
  List<Object?> get props => [movies, page, hasReachedMax];
}

class MovieListError extends MovieListState {
  const MovieListError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

class MovieListCubit extends Cubit<MovieListState> {
  MovieListCubit({required this.movieRepository}) : super(MovieListInitial());

  final MovieRepository movieRepository;

  int _currentPage = 1;
  bool _hasReachedMax = false;

  Future<void> loadPopularMovies() async {
    _currentPage = 1;
    _hasReachedMax = false;
    emit(MovieListLoading());

    try {
      final movieResponse = await movieRepository.getPopularMovies(
        page: _currentPage,
      );

      emit(
        MovieListLoaded(
          movies: movieResponse.results,
          page: _currentPage,
          hasReachedMax: _currentPage >= movieResponse.totalPages,
        ),
      );

      _hasReachedMax = _currentPage >= movieResponse.totalPages;
    } catch (e) {
      emit(MovieListError(e.toString()));
    }
  }

  Future<void> loadMoreMovies() async {
    if (_hasReachedMax || state is! MovieListLoaded) {
      return;
    }

    try {
      _currentPage++;
      final movieResponse = await movieRepository.getPopularMovies(
        page: _currentPage,
      );

      final currentState = state as MovieListLoaded;

      /** Spread Operator.  */
      final updatedMovies = [...currentState.movies, ...movieResponse.results];

      _hasReachedMax = _currentPage >= movieResponse.totalPages;

      emit(
        MovieListLoaded(
          movies: updatedMovies,
          page: _currentPage,
          hasReachedMax: _hasReachedMax,
        ),
      );
    } catch (e) {
      _currentPage--;
      emit(MovieListError(e.toString()));
    }
  }

  /// Search movies by query
  /// Resets state and loads search results
  Future<void> searchMovies(String query) async {
    if (query.isEmpty) {
      await loadPopularMovies();
      return;
    }

    _currentPage = 1;
    _hasReachedMax = false;
    emit(MovieListLoading());

    try {
      final movieResponse = await movieRepository.searchMovies(
        query,
        page: _currentPage,
      );

      emit(
        MovieListLoaded(
          movies: movieResponse.results,
          page: _currentPage,
          hasReachedMax: _currentPage >= movieResponse.totalPages,
        ),
      );

      _hasReachedMax = _currentPage >= movieResponse.totalPages;
    } catch (e) {
      emit(MovieListError(e.toString()));
    }
  }
}
