import 'package:dartz/dartz.dart';
import 'package:tv_series_app/common/failure.dart';
import 'package:tv_series_app/domain/entities/movie.dart';
import 'package:tv_series_app/domain/repositories/movie_repository.dart';

class GetPopularMovies {
  final MovieRepository repository;

  GetPopularMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getPopularMovies();
  }
}
