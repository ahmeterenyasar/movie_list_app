import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/movie.dart';
import '../repositories/favorites_repository.dart';

/// State class for favorites
/// Manages the list of favorited movies
abstract class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object?> get props => [];
}

class FavoritesInitial extends FavoritesState {}

class FavoritesLoading extends FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  const FavoritesLoaded(this.favorites);

  final List<Movie> favorites;

  @override
  List<Object?> get props => [favorites];
}

class FavoritesError extends FavoritesState {
  const FavoritesError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit({required this.favoritesRepository})
    : super(FavoritesInitial());

  final FavoritesRepository favoritesRepository;

  Future<void> loadFavorites() async {
    emit(FavoritesLoading());

    try {
      final favorites = await favoritesRepository.getFavorites();
      emit(FavoritesLoaded(favorites));
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  Future<void> addFavorite(Movie movie) async {
    final success = await favoritesRepository.addFavorite(movie);

    if (success) {
      await loadFavorites();
    }
  }

  Future<void> removeFavorite(int movieId) async {
    final success = await favoritesRepository.removeFavorite(movieId);

    if (success) {
      if (state is FavoritesLoaded) {
        final currentState = state as FavoritesLoaded;
        final updatedFavorites = List<Movie>.from(currentState.favorites)
          ..removeWhere((movie) => movie.id == movieId);
        emit(FavoritesLoaded(updatedFavorites));
      }
    }
  }
}
