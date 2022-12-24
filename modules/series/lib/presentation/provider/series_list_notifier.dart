import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/domain/usecases/get_on_air_series.dart';
import 'package:series/domain/usecases/get_popular_series.dart';
import 'package:series/domain/usecases/get_top_rated_series.dart';

class SeriesListNotifier extends ChangeNotifier {
  var _onAirSeries = <Series>[];
  List<Series> get onAirSeries => _onAirSeries;

  RequestState _onAirState = RequestState.empty;
  RequestState get onAirState => _onAirState;

  var _popularSeries = <Series>[];
  List<Series> get popularSeries => _popularSeries;

  RequestState _popularSeriesState = RequestState.empty;
  RequestState get popularSeriesState => _popularSeriesState;

  var _topRatedSeries = <Series>[];
  List<Series> get topRatedSeries => _topRatedSeries;

  RequestState _topRatedSeriesState = RequestState.empty;
  RequestState get topRatedSeriesState => _topRatedSeriesState;

  String _message = '';
  String get message => _message;

  SeriesListNotifier({
    required this.getOnAirSeries,
    required this.getPopularSeries,
    required this.getTopRatedSeries,
  });

  final GetOnAirSeries getOnAirSeries;
  final GetPopularSeries getPopularSeries;
  final GetTopRatedSeries getTopRatedSeries;

  Future<void> fetchOnAirSeries() async {
    _onAirState = RequestState.loading;
    notifyListeners();

    final result = await getOnAirSeries.execute();
    result.fold(
      (failure) {
        _onAirState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (seriesdata) {
        _onAirState = RequestState.loaded;
        _onAirSeries = seriesdata;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularSeries() async {
    _popularSeriesState = RequestState.loading;
    notifyListeners();

    final result = await getPopularSeries.execute();
    result.fold(
      (failure) {
        _popularSeriesState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (seriesdata) {
        _popularSeriesState = RequestState.loaded;
        _popularSeries = seriesdata;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedSeries() async {
    _topRatedSeriesState = RequestState.loading;
    notifyListeners();

    final result = await getTopRatedSeries.execute();
    result.fold(
      (failure) {
        _topRatedSeriesState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (seriesdata) {
        _topRatedSeriesState = RequestState.loaded;
        _topRatedSeries = seriesdata;
        notifyListeners();
      },
    );
  }
}
