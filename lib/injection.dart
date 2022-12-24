import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:tv_series_app/data/datasource/db/database_helper.dart';
import 'package:tv_series_app/data/datasource/movie_local_data_source.dart';
import 'package:tv_series_app/data/datasource/movie_remote_data_source.dart';
import 'package:tv_series_app/data/datasource/series_api_datasource.dart';
import 'package:tv_series_app/data/datasource/series_local_datasource.dart';
import 'package:tv_series_app/data/repositories/movie_repository_impl.dart';
import 'package:tv_series_app/data/repositories/series_repository_impl.dart';
import 'package:tv_series_app/domain/repositories/movie_repository.dart';
import 'package:tv_series_app/domain/repositories/series_repository.dart';
import 'package:tv_series_app/domain/usecases/add_watchlist.dart';
import 'package:tv_series_app/domain/usecases/get_movie_detail.dart';
import 'package:tv_series_app/domain/usecases/get_movie_recommendations.dart';
import 'package:tv_series_app/domain/usecases/get_movie_watchlist_status.dart';
import 'package:tv_series_app/domain/usecases/get_now_playing_movies.dart';
import 'package:tv_series_app/domain/usecases/get_on_air_series.dart';
import 'package:tv_series_app/domain/usecases/get_popular_movies.dart';
import 'package:tv_series_app/domain/usecases/get_popular_series.dart';
import 'package:tv_series_app/domain/usecases/get_series_detail.dart';
import 'package:tv_series_app/domain/usecases/get_series_recommendations.dart';
import 'package:tv_series_app/domain/usecases/get_top_rated_movies.dart';
import 'package:tv_series_app/domain/usecases/get_top_rated_series.dart';
import 'package:tv_series_app/domain/usecases/get_watchlist.dart';
import 'package:tv_series_app/domain/usecases/get_watchlist_movies.dart';
import 'package:tv_series_app/domain/usecases/get_watchlist_status.dart';
import 'package:tv_series_app/domain/usecases/remove_movie_watchlist.dart';
import 'package:tv_series_app/domain/usecases/remove_watchlist.dart';
import 'package:tv_series_app/domain/usecases/save_watchlist.dart';
import 'package:tv_series_app/domain/usecases/search_movies.dart';
import 'package:tv_series_app/domain/usecases/search_series.dart';
import 'package:tv_series_app/presentation/provider/detail_series_provider.dart';
import 'package:tv_series_app/presentation/provider/movie_detail_notifier.dart';
import 'package:tv_series_app/presentation/provider/movie_list_notifier.dart';
import 'package:tv_series_app/presentation/provider/movie_search_notifier.dart';
import 'package:tv_series_app/presentation/provider/now_playing_movie_notifier.dart';
import 'package:tv_series_app/presentation/provider/on_air_series_provider.dart';
import 'package:tv_series_app/presentation/provider/popular_movies_notifier.dart';
import 'package:tv_series_app/presentation/provider/popular_series_provider.dart';
import 'package:tv_series_app/presentation/provider/search_series_provider.dart';
import 'package:tv_series_app/presentation/provider/series_list_notifier.dart';
import 'package:tv_series_app/presentation/provider/top_rated_movies_notifier.dart';
import 'package:tv_series_app/presentation/provider/top_rated_series_provider.dart';
import 'package:tv_series_app/presentation/provider/watchlist_movie_notifier.dart';
import 'package:tv_series_app/presentation/provider/watchlist_provider.dart';

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(
    () => TopRatedSeriesNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => PopularSeriesNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => OnAirSeriesNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => DetailSeriesNotifier(
      getDetailSeries: locator(),
      getSeriesRecommendations: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchListNotifier(
        getWatchListStatus: locator(),
        saveWatchlist: locator(),
        removeWatchlist: locator(),
        getWatchlistSeries: locator()),
  );
  locator.registerFactory(
    () => SearchSeriesNotifier(
      locator(),
    ),
  );

  locator.registerFactory(
    () => MovieListNotifier(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailNotifier(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieSearchNotifier(
      searchMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesNotifier(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieNotifier(
      getWatchlistMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => SeriesListNotifier(
      getOnAirSeries: locator(),
      getPopularSeries: locator(),
      getTopRatedSeries: locator(),
    ),
  );
  locator.registerFactory(
    () => NowPlayingMovieNotifier(
      locator(),
    ),
  );
  // use case

  locator.registerLazySingleton(() => GetTopRatedSeries(locator()));
  locator.registerLazySingleton(() => GetPopularSeries(locator()));
  locator.registerLazySingleton(() => GetOnAirSeries(locator()));
  locator.registerLazySingleton(() => GetSeriesDetail(locator()));
  locator.registerLazySingleton(() => GetSeriesRecommendations(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => GetWatchlist(locator()));
  locator.registerLazySingleton(() => SearchSeries(locator()));
  //movie
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetMovieWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveMovieWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveMovieWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  // repository
  locator.registerLazySingleton<SeriesRepository>(
    () => SeriesRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator
      .registerLazySingleton<SeriesAPI>(() => SeriesAPIImpl(client: locator()));
  locator.registerLazySingleton<SeriesLocalDataSource>(
      () => SeriesLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());
}
