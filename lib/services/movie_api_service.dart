import 'package:dio/dio.dart';
import '../models/movie.dart';
import '../config/api_config.dart';

class MovieApiService {
  MovieApiService({Dio? dio}) : _dio = dio ?? Dio();

  final Dio _dio;

  Future<MovieResponse> getPopularMovies({int page = 1}) async {
    try {
      final response = await _dio.get(
        '${ApiConfig.baseUrl}/movie/popular',
        queryParameters: {'api_key': ApiConfig.apiKey, 'page': page},
      );

      return MovieResponse.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw Exception('Dio Exception: Failed to fetch movies ${e.message}');
    }
  }

  Future<MovieResponse> searchMovies(String query, {int page = 1}) async {
    try {
      final response = await _dio.get(
        '${ApiConfig.baseUrl}/search/movie',
        queryParameters: {
          'api_key': ApiConfig.apiKey,
          'query': query,
          'page': page,
        },
      );
      return MovieResponse.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw Exception('Dio Exception: Failed to search movies ${e.message}');
    }
  }
}
