import 'package:dartz/dartz.dart';
import 'package:tv_series_app/common/failure.dart';
import 'package:tv_series_app/domain/entities/detail.dart';
import 'package:tv_series_app/domain/repositories/series_repository.dart';

class GetSeriesDetail {
  final SeriesRepository repository;
  static const IMG_URL = 'https://image.tmdb.org/t/p/original/';
  static const BD_URL = 'https://www.themoviedb.org/t/p/w533_and_h300_bestv2';
  GetSeriesDetail(this.repository);

  Future<Either<Failure, Detail>> execute(int id) {
    return repository.getSeriesDetail(id);
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
