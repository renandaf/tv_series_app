library series;

export 'presentation/pages/detail_series_page.dart';
export 'presentation/pages/home_series_page.dart';
export 'presentation/pages/on_air_series_page.dart';
export 'presentation/pages/popular_series_page.dart';
export 'presentation/pages/search_series_page.dart';
export 'presentation/pages/top_rated_series_page.dart';
export 'presentation/pages/episode_detail_page.dart';
export 'presentation/bloc/series_bloc.dart';

export 'data/models/watchlist_model.dart';

export 'domain/usecases/add_watchlist.dart';
export 'domain/usecases/get_on_air_series.dart';
export 'domain/usecases/get_popular_series.dart';
export 'domain/usecases/get_series_detail.dart';
export 'domain/usecases/get_series_recommendations.dart';
export 'domain/usecases/get_top_rated_series.dart';
export 'domain/usecases/get_watchlist.dart';
export 'domain/usecases/get_watchlist_status.dart';
export 'domain/usecases/remove_watchlist.dart';
export 'domain/usecases/search_series.dart';
export 'domain/usecases/get_season.dart';

export 'domain/repositories/series_repository.dart';

export 'data/datasource/series_api_datasource.dart';
export 'data/datasource/series_local_datasource.dart';
export 'data/repositories/series_repository_impl.dart';
