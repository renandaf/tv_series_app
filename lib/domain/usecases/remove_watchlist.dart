import 'package:dartz/dartz.dart';
import 'package:tv_series_app/common/failure.dart';
import 'package:tv_series_app/domain/entities/detail.dart';
import 'package:tv_series_app/domain/repositories/series_repository.dart';

class RemoveWatchlist {
  final SeriesRepository repository;

  RemoveWatchlist(this.repository);

  Future<Either<Failure, String>> execute(Detail series) {
    return repository.removeWatchlist(series);
  }
}
