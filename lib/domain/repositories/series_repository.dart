import 'package:dartz/dartz.dart';
import 'package:tv_series_app/common/failure.dart';
import 'package:tv_series_app/domain/entities/detail.dart';
import 'package:tv_series_app/domain/entities/series.dart';

abstract class SeriesRepository {
  Future<Either<Failure, List<Series>>> getOnAirSeries();
  Future<Either<Failure, List<Series>>> getPopularSeries();
  Future<Either<Failure, List<Series>>> getTopRatedSeries();
  Future<Either<Failure, Detail>> getSeriesDetail(int id);
  Future<Either<Failure, List<Series>>> getSeriesRecommendations(int id);
  Future<Either<Failure, List<Series>>> searchSeries(String query);
  Future<Either<Failure, String>> addWatchlist(Detail series);
  Future<Either<Failure, String>> removeWatchlist(Detail series);
  Future<bool> isAddedToWatchlist(int id);
  Future<Either<Failure, List<Detail>>> getWatchlistSeries();
}
