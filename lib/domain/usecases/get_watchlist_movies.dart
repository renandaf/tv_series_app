import 'package:dartz/dartz.dart';
import 'package:tv_series_app/common/failure.dart';
import 'package:tv_series_app/domain/entities/movie_detail.dart';
import 'package:tv_series_app/domain/repositories/movie_repository.dart';

class GetWatchlistMovies {
  final MovieRepository _repository;

  GetWatchlistMovies(this._repository);

  Future<Either<Failure, List<MovieDetail>>> execute() {
    return _repository.getWatchlistMovies();
  }
}
