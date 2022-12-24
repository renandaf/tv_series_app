import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:movies/domain/entities/movie_detail.dart';
import 'package:movies/domain/repositories/movie_repository.dart';

class GetWatchlistMovies {
  final MovieRepository _repository;

  GetWatchlistMovies(this._repository);

  Future<Either<Failure, List<MovieDetail>>> execute() {
    return _repository.getWatchlistMovies();
  }
}
