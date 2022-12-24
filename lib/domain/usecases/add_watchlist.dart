import 'package:dartz/dartz.dart';
import 'package:tv_series_app/common/failure.dart';
import 'package:tv_series_app/domain/entities/detail.dart';
import 'package:tv_series_app/domain/repositories/series_repository.dart';

class SaveWatchlist {
  final SeriesRepository repository;

  SaveWatchlist(this.repository);

  Future<Either<Failure, String>> execute(Detail series) {
    return repository.addWatchlist(series);
  }
}
