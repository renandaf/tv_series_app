library movies;

export 'presentation/pages/detail_movie_page.dart';
export 'presentation/pages/home_movies_page.dart';
export 'presentation/pages/now_playing_movie_page.dart';
export 'presentation/pages/popular_movie_page.dart';
export 'presentation/pages/search_movie_page.dart';
export 'presentation/pages/top_rated_movie_page.dart';

export 'presentation/bloc/movie_bloc.dart';

export 'data/models/movie_table.dart';

export 'domain/usecases/get_movie_detail.dart';
export 'domain/usecases/get_movie_recommendations.dart';
export 'domain/usecases/get_movie_watchlist_status.dart';
export 'domain/usecases/get_now_playing_movies.dart';
export 'domain/usecases/get_popular_movies.dart';
export 'domain/usecases/get_top_rated_movies.dart';
export 'domain/usecases/get_watchlist_movies.dart';
export 'domain/usecases/remove_movie_watchlist.dart';
export 'domain/usecases/save_watchlist.dart';
export 'domain/usecases/search_movies.dart';

export 'domain/repositories/movie_repository.dart';

export 'data/datasource/movie_local_data_source.dart';
export 'data/datasource/movie_remote_data_source.dart';
export 'data/repositories/movie_repository_impl.dart';
