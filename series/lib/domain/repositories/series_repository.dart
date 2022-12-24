import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:series/domain/entities/detail.dart';
import 'package:series/domain/entities/season.dart';
import 'package:series/domain/entities/series.dart';

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
  Future<Either<Failure, Season>> getSeasonDetail(int id, int season);
}
