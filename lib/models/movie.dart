import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  const Movie({
    required this.id,
    required this.title,
    this.overview,
    this.posterPath,
    required this.voteAverage,
    this.releaseDate,
  });

  final int id;
  final String title;
  final String? overview;
  final String? posterPath;
  final double voteAverage;
  final String? releaseDate;

  String? get fullImageUrl =>
      posterPath != null ? 'https://image.tmdb.org/t/p/w500$posterPath' : null;

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] as int,
      title: json['title'] as String? ?? 'Unknown',
      overview: json['overview'] as String?,
      posterPath: json['poster_path'] as String?,
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      releaseDate: json['release_date'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'overview': overview,
      'poster_path': posterPath,
      'vote_average': voteAverage,
      'release_date': releaseDate,
    };
  }

  @override
  List<Object?> get props => [
    id,
    title,
    overview,
    posterPath,
    voteAverage,
    releaseDate,
  ];
}

class MovieResponse extends Equatable {
  const MovieResponse({
    required this.results,
    required this.page,
    required this.totalPages,
    required this.totalResults,
  });

  final List<Movie> results;
  final int page;
  final int totalPages;
  final int totalResults;

  factory MovieResponse.fromJson(Map<String, dynamic> json) {
    return MovieResponse(
      results: (json['results'] as List)
          .map((movie) => Movie.fromJson(movie as Map<String, dynamic>))
          .toList(),
      page: json['page'] as int,
      totalPages: json['total_pages'] as int,
      totalResults: json['total_results'] as int,
    );
  }

  @override
  List<Object?> get props => [results, page, totalPages, totalResults];
}
