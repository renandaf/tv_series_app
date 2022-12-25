part of 'series_bloc.dart';

abstract class SeriesEvent extends Equatable {
  const SeriesEvent();

  @override
  List<Object> get props => [];
}

class OnSeasonDetail extends SeriesEvent {
  final int id;
  final int season;
  const OnSeasonDetail(this.id, this.season);
  @override
  List<Object> get props => [id, season];
}

class OnOnAirSeries extends SeriesEvent {}

class OnPopularSeries extends SeriesEvent {}

class OnTopRatedSeries extends SeriesEvent {}

class OnSeriesRecommendation extends SeriesEvent {
  final int id;
  const OnSeriesRecommendation(this.id);
  @override
  List<Object> get props => [id];
}

class OnDetailSeries extends SeriesEvent {
  final int id;
  const OnDetailSeries(this.id);
  @override
  List<Object> get props => [id];
}

class OnQuerySeriesChanged extends SeriesEvent {
  final String query;

  const OnQuerySeriesChanged(this.query);

  @override
  List<Object> get props => [query];
}

class OnSeriesWatchlist extends SeriesEvent {}

class OnSeriesWatchlistStatus extends SeriesEvent {
  final int id;
  const OnSeriesWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}

class OnAddSeriesWatchlist extends SeriesEvent {
  final Detail seriesDetail;
  const OnAddSeriesWatchlist(this.seriesDetail);

  @override
  List<Object> get props => [seriesDetail];
}

class OnRemoveSeriesWatchlist extends SeriesEvent {
  final Detail seriesDetail;
  const OnRemoveSeriesWatchlist(this.seriesDetail);

  @override
  List<Object> get props => [seriesDetail];
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
