import 'package:flutter/material.dart';
import 'package:tv_series_app/common/enum.dart';
import 'package:tv_series_app/domain/entities/series.dart';
import 'package:tv_series_app/domain/usecases/get_on_air_series.dart';
import 'package:tv_series_app/domain/usecases/get_popular_series.dart';
import 'package:tv_series_app/domain/usecases/get_top_rated_series.dart';

class SeriesListNotifier extends ChangeNotifier {
  var _onAirSeries = <Series>[];
  List<Series> get onAirSeries => _onAirSeries;

  RequestState _onAirState = RequestState.Empty;
  RequestState get onAirState => _onAirState;

  var _popularSeries = <Series>[];
  List<Series> get popularSeries => _popularSeries;

  RequestState _popularSeriesState = RequestState.Empty;
  RequestState get popularSeriesState => _popularSeriesState;

  var _topRatedSeries = <Series>[];
  List<Series> get topRatedSeries => _topRatedSeries;

  RequestState _topRatedSeriesState = RequestState.Empty;
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
    _onAirState = RequestState.Loading;
    notifyListeners();

    final result = await getOnAirSeries.execute();
    result.fold(
      (failure) {
        _onAirState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (seriesdata) {
        _onAirState = RequestState.Loaded;
        _onAirSeries = seriesdata;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularSeries() async {
    _popularSeriesState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularSeries.execute();
    result.fold(
      (failure) {
        _popularSeriesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (seriesdata) {
        _popularSeriesState = RequestState.Loaded;
        _popularSeries = seriesdata;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedSeries() async {
    _topRatedSeriesState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedSeries.execute();
    result.fold(
      (failure) {
        _topRatedSeriesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (seriesdata) {
        _topRatedSeriesState = RequestState.Loaded;
        _topRatedSeries = seriesdata;
        notifyListeners();
      },
    );
  }
}
