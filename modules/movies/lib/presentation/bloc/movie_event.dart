part of 'movie_bloc.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object> get props => [];
}

class OnNowPlayingMovie extends MovieEvent {}

class OnPopularMovie extends MovieEvent {}

class OnTopRatedMovie extends MovieEvent {}

class OnMovieRecommendation extends MovieEvent {
  final int id;
  const OnMovieRecommendation(this.id);
  @override
  List<Object> get props => [id];
}

class OnDetailMovie extends MovieEvent {
  final int id;
  const OnDetailMovie(this.id);
  @override
  List<Object> get props => [id];
}

class OnMovieWatchlist extends MovieEvent {}

class OnMovieWatchlistStatus extends MovieEvent {
  final int id;
  const OnMovieWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}

class OnQueryChanged extends MovieEvent {
  final String query;

  const OnQueryChanged(this.query);

  @override
  List<Object> get props => [query];
}

class OnAddMovieWatchlist extends MovieEvent {
  final MovieDetail movieDetail;
  const OnAddMovieWatchlist(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class OnRemoveMovieWatchlist extends MovieEvent {
  final MovieDetail movieDetail;
  const OnRemoveMovieWatchlist(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
