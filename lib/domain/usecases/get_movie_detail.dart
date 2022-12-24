import 'package:dartz/dartz.dart';
import 'package:tv_series_app/common/failure.dart';
import 'package:tv_series_app/domain/entities/movie_detail.dart';
import 'package:tv_series_app/domain/repositories/movie_repository.dart';

class GetMovieDetail {
  final MovieRepository repository;
  GetMovieDetail(this.repository);
  static const IMG_URL = 'https://image.tmdb.org/t/p/original/';
  static const BD_URL = 'https://www.themoviedb.org/t/p/w533_and_h300_bestv2';
  Future<Either<Failure, MovieDetail>> execute(int id) {
    return repository.getMovieDetail(id);
  }

  static posterImage(String path) {
    String url = "$IMG_URL$path";
    return url;
  }

  static backDropImage(String path) {
    String url = "$BD_URL$path";
    return url;
  }
}
