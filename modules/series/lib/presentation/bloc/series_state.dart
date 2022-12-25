part of 'series_bloc.dart';

abstract class SeriesState extends Equatable {
  const SeriesState();

  @override
  List<Object> get props => [];
}

class SeriesEmpty extends SeriesState {}

class SeriesLoading extends SeriesState {}

class SeriesError extends SeriesState {
  final String message;

  const SeriesError(this.message);

  @override
  List<Object> get props => [message];
}

class SeasonHasData extends SeriesState {
  final Season result;

  const SeasonHasData(this.result);

  @override
  List<Object> get props => [result];
}

class SeriesListHasData extends SeriesState {
  final List<Series> result;

  const SeriesListHasData(this.result);

  @override
  List<Object> get props => [result];
}

class DetailHasData extends SeriesState {
  final Detail result;

  const DetailHasData(this.result);

  @override
  List<Object> get props => [result];
}

class WatchlistSeriesHasData extends SeriesState {
  final List<Detail> result;

  const WatchlistSeriesHasData(this.result);

  @override
  List<Object> get props => [result];
}

class SeriesWatchlistMessage extends SeriesState {
  final String message;

  const SeriesWatchlistMessage(this.message);

  @override
  List<Object> get props => [message];
}

class SeriesWatchlistStatus extends SeriesState {
  final bool status;

  const SeriesWatchlistStatus(this.status);

  @override
  List<Object> get props => [status];
}
