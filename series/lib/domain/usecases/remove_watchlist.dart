import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:series/domain/entities/detail.dart';
import 'package:series/domain/repositories/series_repository.dart';

class RemoveWatchlist {
  final SeriesRepository repository;

  RemoveWatchlist(this.repository);

  Future<Either<Failure, String>> execute(Detail series) {
    return repository.removeWatchlist(series);
  }
}
