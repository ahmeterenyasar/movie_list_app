import '../models/movie.dart';
import '../services/movie_api_service.dart';

class MovieRepository {
  MovieRepository({required this.apiService});

  final MovieApiService apiService;

  Future<MovieResponse> getPopularMovies({int page = 1}) async {
    return await apiService.getPopularMovies(page: page);
  }

  Future<MovieResponse> searchMovies(String query, {int page = 1}) async {
    return await apiService.searchMovies(query, page: page);
  }
}
