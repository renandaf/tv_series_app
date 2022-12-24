import 'package:equatable/equatable.dart';
import 'package:series/data/models/episode_model.dart';
import 'package:series/domain/entities/season.dart';

class SeasonDetail extends Equatable {
  const SeasonDetail({
    required this.id,
    required this.airDate,
    required this.episodes,
    required this.name,
    required this.overview,
    required this.seasonDetailId,
    required this.posterPath,
    required this.seasonNumber,
  });

  final String id;
  final String airDate;
  final List<EpisodeModel> episodes;
  final String name;
  final String overview;
  final int seasonDetailId;
  final String posterPath;
  final int seasonNumber;

  factory SeasonDetail.fromJson(Map<String, dynamic> json) => SeasonDetail(
        id: json["_id"] ?? "",
        airDate: json["air_date"] ?? "",
        episodes: List<EpisodeModel>.from(
            json["episodes"].map((x) => EpisodeModel.fromJson(x))),
        name: json["name"] ?? "",
        overview: json["overview"] ?? "",
        seasonDetailId: json["id"] ?? "",
        posterPath: json["poster_path"] ?? "",
        seasonNumber: json["season_number"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "air_date": airDate,
        "episodes": List<dynamic>.from(episodes.map((x) => x.toJson())),
        "name": name,
        "overview": overview,
        "id": seasonDetailId,
        "poster_path": posterPath,
        "season_number": seasonNumber,
      };

  Season toEntity() {
    return Season(
      id: id,
      airDate: airDate,
      episodes: episodes.map((genre) => genre.toEntity()).toList(),
      name: name,
      overview: overview,
      seasonDetailId: seasonDetailId,
      posterPath: posterPath,
      seasonNumber: seasonNumber,
    );
  }

  @override
  List<Object?> get props => [
        id,
        airDate,
        episodes,
        name,
        overview,
        seasonDetailId,
        posterPath,
        seasonNumber,
      ];
}
