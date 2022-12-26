import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/entities/movie_detail.dart';
import 'package:movies/movies.dart';
import 'package:rxdart/rxdart.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class SearchMovieBloc extends Bloc<MovieEvent, MovieState> {
  final SearchMovies searchMovie;

  SearchMovieBloc(this.searchMovie) : super(MovieEmpty()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;
      emit(MovieLoading());

      final searchMoviesResult = await searchMovie.execute(query);

      searchMoviesResult.fold(
        (failure) => emit(
          MovieError(failure.message),
        ),
        (movieData) => emit(
          MovieListHasData(movieData),
        ),
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}

class NowPlayingMovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetNowPlayingMovies getNowPlayingMovies;

  NowPlayingMovieBloc(this.getNowPlayingMovies) : super(MovieEmpty()) {
    on<OnNowPlayingMovie>((event, emit) async {
      emit(MovieLoading());

      final getNowPlayingMoviesResult = await getNowPlayingMovies.execute();

      getNowPlayingMoviesResult.fold(
        (failure) => emit(
          MovieError(failure.message),
        ),
        (movieData) => emit(
          MovieListHasData(movieData),
        ),
      );
    });
  }
}

class PopularMovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetPopularMovies getPopularMovies;

  PopularMovieBloc(this.getPopularMovies) : super(MovieEmpty()) {
    on<OnPopularMovie>((event, emit) async {
      emit(MovieLoading());

      final getPopularMoviesResult = await getPopularMovies.execute();

      getPopularMoviesResult.fold(
        (failure) => emit(
          MovieError(failure.message),
        ),
        (movieData) => emit(
          MovieListHasData(movieData),
        ),
      );
    });
  }
}

class TopRatedMovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetTopRatedMovies getTopRatedMovies;

  TopRatedMovieBloc(this.getTopRatedMovies) : super(MovieEmpty()) {
    on<OnTopRatedMovie>((event, emit) async {
      emit(MovieLoading());

      final getTopRatedMoviesResult = await getTopRatedMovies.execute();

      getTopRatedMoviesResult.fold(
        (failure) => emit(
          MovieError(failure.message),
        ),
        (movieData) => emit(
          MovieListHasData(movieData),
        ),
      );
    });
  }
}

class MovieDetailBloc extends Bloc<MovieEvent, MovieState> {
  final GetMovieDetail getMovieDetail;

  MovieDetailBloc(this.getMovieDetail) : super(MovieEmpty()) {
    on<OnDetailMovie>((event, emit) async {
      final id = event.id;
      emit(MovieLoading());
      final getMovieDetailResult = await getMovieDetail.execute(id);
      getMovieDetailResult.fold(
        (failure) => emit(
          MovieError(failure.message),
        ),
        (movie) => emit(
          MovieDetailHasData(movie),
        ),
      );
    });
  }
}

class MovieRecommendationBloc extends Bloc<MovieEvent, MovieState> {
  final GetMovieRecommendations getMovieRecommendations;

  MovieRecommendationBloc(this.getMovieRecommendations) : super(MovieEmpty()) {
    on<OnMovieRecommendation>((event, emit) async {
      final id = event.id;
      emit(MovieLoading());
      final getMovieRecommendationsResult =
          await getMovieRecommendations.execute(id);
      getMovieRecommendationsResult.fold(
        (failure) => emit(
          MovieError(failure.message),
        ),
        (recom) => emit(
          MovieListHasData(recom),
        ),
      );
    });
  }
}

class MovieWatchlistBloc extends Bloc<MovieEvent, MovieState> {
  final GetWatchlistMovies getWatchlistMovies;
  final GetMovieWatchListStatus getMovieWatchListStatus;
  final SaveMovieWatchlist saveMovieWatchlist;
  final RemoveMovieWatchlist removeMovieWatchlist;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  MovieWatchlistBloc(
    this.getMovieWatchListStatus,
    this.getWatchlistMovies,
    this.removeMovieWatchlist,
    this.saveMovieWatchlist,
  ) : super(MovieEmpty()) {
    on<OnMovieWatchlist>((event, emit) async {
      emit(MovieLoading());
      final getMovieWatchlistResult = await getWatchlistMovies.execute();
      getMovieWatchlistResult.fold(
        (failure) => emit(
          MovieError(failure.message),
        ),
        (data) => emit(
          WatchlistMovieHasData(data),
        ),
      );
    });

    on<OnMovieWatchlistStatus>((event, emit) async {
      final id = event.id;

      emit(MovieLoading());

      final getMovieWatchlistStatusResult =
          await getMovieWatchListStatus.execute(id);
      emit(MovieWatchlistStatus(getMovieWatchlistStatusResult));
    });

    on<OnAddMovieWatchlist>((event, emit) async {
      final movie = event.movieDetail;

      emit(MovieLoading());

      final getAddMovieWatchlistResult =
          await saveMovieWatchlist.execute(movie);

      getAddMovieWatchlistResult.fold(
        (failure) => emit(
          MovieError(failure.message),
        ),
        (successMessage) => emit(
          MovieWatchlistMessage(successMessage),
        ),
      );
    });

    on<OnRemoveMovieWatchlist>((event, emit) async {
      final movie = event.movieDetail;

      emit(MovieLoading());

      final getRemoveMovieWatchlistResult =
          await removeMovieWatchlist.execute(movie);

      getRemoveMovieWatchlistResult.fold(
        (failure) => emit(
          MovieError(failure.message),
        ),
        (successMessage) => emit(
          MovieWatchlistMessage(successMessage),
        ),
      );
    });
  }
}
