import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:series/domain/entities/season.dart';
import 'package:series/domain/repositories/series_repository.dart';

class GetSeason {
  final SeriesRepository repository;
  GetSeason(this.repository);

  Future<Either<Failure, Season>> execute(int id, int season) {
    return repository.getSeasonDetail(id, season);
  }
}
