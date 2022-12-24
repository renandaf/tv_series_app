import 'package:dartz/dartz.dart';
import 'package:tv_series_app/common/failure.dart';
import 'package:tv_series_app/domain/entities/detail.dart';
import 'package:tv_series_app/domain/repositories/series_repository.dart';

class GetWatchlist {
  final SeriesRepository _repository;

  GetWatchlist(this._repository);

  Future<Either<Failure, List<Detail>>> execute() {
    return _repository.getWatchlistSeries();
  }
}
