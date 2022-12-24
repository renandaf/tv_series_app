import 'package:equatable/equatable.dart';
import 'package:movies/domain/entities/movie_detail.dart';

class MovieTable extends Equatable {
  final int id;
  final String? title;
  final String? posterPath;
  final String? overview;
  final double? voteAverage;

  const MovieTable({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
    required this.voteAverage,
  });

  factory MovieTable.fromEntity(MovieDetail movie) => MovieTable(
      id: movie.id!,
      title: movie.title,
      posterPath: movie.posterPath,
      overview: movie.overview,
      voteAverage: movie.voteAverage);

  factory MovieTable.fromMap(Map<String, dynamic> map) => MovieTable(
        id: map['id'],
        title: map['title'],
        posterPath: map['posterPath'] ?? "",
        overview: map['overview'] ?? "",
        voteAverage: map['voteAverage'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'posterPath': posterPath,
        'overview': overview,
        'voteAverage': voteAverage
      };

  MovieDetail toEntity() => MovieDetail.watchlist(
        id: id,
        overview: overview!,
        posterPath: posterPath!,
        title: title!,
        voteAverage: voteAverage!,
      );

  @override
  List<Object?> get props => [id, title, posterPath, overview, voteAverage];
}
