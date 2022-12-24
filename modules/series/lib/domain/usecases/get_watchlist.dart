import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:series/domain/entities/detail.dart';
import 'package:series/domain/repositories/series_repository.dart';

class GetWatchlist {
  final SeriesRepository _repository;

  GetWatchlist(this._repository);

  Future<Either<Failure, List<Detail>>> execute() {
    return _repository.getWatchlistSeries();
  }
}
