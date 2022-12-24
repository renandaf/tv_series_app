import 'package:dartz/dartz.dart';
import 'package:tv_series_app/common/failure.dart';
import 'package:tv_series_app/domain/entities/series.dart';
import 'package:tv_series_app/domain/repositories/series_repository.dart';

class GetTopRatedSeries {
  final SeriesRepository repository;

  GetTopRatedSeries(this.repository);

  Future<Either<Failure, List<Series>>> execute() {
    return repository.getTopRatedSeries();
  }
}
