import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/movie.dart';

class FavoritesRepository {
  static const String _favoritesKey = 'favorites';

  late final SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<List<Movie>> getFavorites() async {
    final favoritesJson = _prefs.getString(_favoritesKey);
    if (favoritesJson == null) {
      return [];
    }

    final List<dynamic> decoded = json.decode(favoritesJson);
    return decoded
        .map((movie) => Movie.fromJson(movie as Map<String, dynamic>))
        .toList();
  }

  Future<bool> addFavorite(Movie movie) async {
    final favorites = await getFavorites();

    if (favorites.any((m) => m.id == movie.id)) {
      return false;
    }

    favorites.add(movie);
    return await _saveFavorites(favorites);
  }

  Future<bool> removeFavorite(int movieId) async {
    final favorites = await getFavorites();
    favorites.removeWhere((movie) => movie.id == movieId);
    return await _saveFavorites(favorites);
  }

  Future<bool> _saveFavorites(List<Movie> favorites) async {
    final favoritesJson = json.encode(
      favorites.map((movie) => movie.toJson()).toList(),
    );
    return await _prefs.setString(_favoritesKey, favoritesJson);
  }

  Future<bool> clearFavorites() async {
    return await _prefs.remove(_favoritesKey);
  }
}
