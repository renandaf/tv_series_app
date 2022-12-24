import 'package:equatable/equatable.dart';
import 'package:series/domain/entities/detail.dart';

class SeriesTable extends Equatable {
  final int? id;
  final String? title;
  final String? posterPath;
  final double? voteAverage;
  final String? overview;

  const SeriesTable({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.voteAverage,
    required this.overview,
  });

  factory SeriesTable.fromEntity(Detail series) => SeriesTable(
      id: series.id,
      title: series.name,
      posterPath: series.posterPath,
      voteAverage: series.voteAverage,
      overview: series.overview);

  factory SeriesTable.fromMap(Map<String, dynamic> map) => SeriesTable(
        id: map['id'],
        title: map['title'],
        posterPath: map['posterPath'] ?? "",
        voteAverage: map['voteAverage'] ?? 0,
        overview: map['overview'] ?? "",
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'posterPath': posterPath,
        'voteAverage': voteAverage,
        'overview': overview,
      };

  Detail toEntity() => Detail.watchlist(
      id: id,
      posterPath: posterPath,
      name: title,
      voteAverage: voteAverage,
      overview: overview);

  @override
  List<Object?> get props => [id, title, posterPath, voteAverage, overview];
}
