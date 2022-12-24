import 'package:equatable/equatable.dart';

class Series extends Equatable {
  const Series({
    required this.posterPath,
    required this.popularity,
    required this.id,
    required this.backdropPath,
    required this.voteAverage,
    required this.overview,
    required this.firstAirDate,
    required this.originCountry,
    required this.genreIds,
    required this.originalLanguage,
    required this.name,
    required this.originalName,
  });

  final String? posterPath;
  final double popularity;
  final int id;
  final dynamic backdropPath;
  final dynamic voteAverage;
  final String overview;
  final String? firstAirDate;
  final List<String> originCountry;
  final List<int> genreIds;
  final String originalLanguage;
  final String name;
  final String originalName;

  @override
  List<Object?> get props => [
        backdropPath,
        firstAirDate,
        id,
        name,
        originCountry,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        voteAverage,
      ];
}
