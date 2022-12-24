import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:series/domain/entities/detail.dart';
import 'package:series/domain/repositories/series_repository.dart';

class GetSeriesDetail {
  final SeriesRepository repository;
  static const imgUrl = 'https://image.tmdb.org/t/p/original/';
  static const bdUrl = 'https://www.themoviedb.org/t/p/w533_and_h300_bestv2';
  GetSeriesDetail(this.repository);

  Future<Either<Failure, Detail>> execute(int id) {
    return repository.getSeriesDetail(id);
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
