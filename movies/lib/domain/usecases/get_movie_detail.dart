import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:movies/domain/entities/movie_detail.dart';
import 'package:movies/domain/repositories/movie_repository.dart';

class GetMovieDetail {
  final MovieRepository repository;
  GetMovieDetail(this.repository);
  static const imgUrl = 'https://image.tmdb.org/t/p/original/';
  static const bdUrl = 'https://www.themoviedb.org/t/p/w533_and_h300_bestv2';
  Future<Either<Failure, MovieDetail>> execute(int id) {
    return repository.getMovieDetail(id);
  }

  static posterImage(String path) {
    String url = "$imgUrl$path";
    return url;
  }

  static backDropImage(String path) {
    String url = "$bdUrl$path";
    return url;
  }
}
