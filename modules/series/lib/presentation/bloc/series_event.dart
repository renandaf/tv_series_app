part of 'series_bloc.dart';

abstract class SeriesEvent {
  const SeriesEvent();
}

class OnSeasonDetail extends SeriesEvent {
  final int id;
  final int season;
  const OnSeasonDetail(this.id, this.season);
}

class OnOnAirSeries extends SeriesEvent {}

class OnPopularSeries extends SeriesEvent {}

class OnTopRatedSeries extends SeriesEvent {}

class OnSeriesRecommendation extends SeriesEvent {
  final int id;
  const OnSeriesRecommendation(this.id);
}

class OnDetailSeries extends SeriesEvent {
  final int id;
  const OnDetailSeries(this.id);
}

class OnQuerySeriesChanged extends SeriesEvent {
  final String query;

  const OnQuerySeriesChanged(this.query);
}

class OnSeriesWatchlist extends SeriesEvent {}

class OnSeriesWatchlistStatus extends SeriesEvent {
  final int id;
  const OnSeriesWatchlistStatus(this.id);
}

class OnAddSeriesWatchlist extends SeriesEvent {
  final Detail seriesDetail;
  const OnAddSeriesWatchlist(this.seriesDetail);
}

class OnRemoveSeriesWatchlist extends SeriesEvent {
  final Detail seriesDetail;
  const OnRemoveSeriesWatchlist(this.seriesDetail);
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
