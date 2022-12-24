import 'package:equatable/equatable.dart';
import 'package:series/domain/entities/series.dart';

class SeriesModel extends Equatable {
  const SeriesModel({
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

  factory SeriesModel.fromJson(Map<String, dynamic> json) => SeriesModel(
        id: json['id'],
        backdropPath: json["backdrop_path"] ?? "",
        firstAirDate: json["first_air_date"],
        name: json["name"],
        originCountry: List<String>.from(json["origin_country"].map((x) => x)),
        originalLanguage: json["original_language"],
        originalName: json["original_name"],
        overview: json["overview"] ?? "",
        popularity: json["popularity"],
        posterPath: json["poster_path"] ?? "",
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        voteAverage: json["vote_average"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        "first_air_date": firstAirDate,
        "id": id,
        "name": name,
        "origin_country": List<dynamic>.from(originCountry.map((x) => x)),
        "original_language": originalLanguage,
        "original_name": originalName,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "vote_average": voteAverage,
      };

  Series toEntity() {
    return Series(
        backdropPath: backdropPath,
        firstAirDate: firstAirDate,
        popularity: popularity,
        genreIds: genreIds,
        id: id,
        name: name,
        originCountry: originCountry,
        originalLanguage: originalLanguage,
        originalName: originalName,
        overview: overview,
        posterPath: posterPath,
        voteAverage: voteAverage);
  }

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
