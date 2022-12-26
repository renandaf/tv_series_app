part of 'movie_bloc.dart';

abstract class MovieEvent {
  const MovieEvent();
}

class OnNowPlayingMovie extends MovieEvent {}

class OnPopularMovie extends MovieEvent {}

class OnTopRatedMovie extends MovieEvent {}

class OnMovieRecommendation extends MovieEvent {
  final int id;
  const OnMovieRecommendation(this.id);
}

class OnDetailMovie extends MovieEvent {
  final int id;
  const OnDetailMovie(this.id);
}

class OnMovieWatchlist extends MovieEvent {}

class OnMovieWatchlistStatus extends MovieEvent {
  final int id;
  const OnMovieWatchlistStatus(this.id);
}

class OnQueryChanged extends MovieEvent {
  final String query;

  const OnQueryChanged(this.query);
}

class OnAddMovieWatchlist extends MovieEvent {
  final MovieDetail movieDetail;
  const OnAddMovieWatchlist(this.movieDetail);
}

class OnRemoveMovieWatchlist extends MovieEvent {
  final MovieDetail movieDetail;
  const OnRemoveMovieWatchlist(this.movieDetail);
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
