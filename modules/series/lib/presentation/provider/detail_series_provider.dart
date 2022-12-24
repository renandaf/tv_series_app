import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:series/domain/entities/detail.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/domain/usecases/get_series_detail.dart';
import 'package:series/domain/usecases/get_series_recommendations.dart';

class DetailSeriesNotifier extends ChangeNotifier {
  final GetSeriesDetail getDetailSeries;
  final GetSeriesRecommendations getSeriesRecommendations;

  DetailSeriesNotifier(
      {required this.getDetailSeries, required this.getSeriesRecommendations});

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  RequestState _stateRecom = RequestState.empty;
  RequestState get stateRecom => _stateRecom;

  late Detail _series;
  Detail get series => _series;

  List<Series> _seriesRecom = [];
  List<Series> get seriesRecom => _seriesRecom;

  String _message = '';
  String get message => _message;

  Future<void> fetchDetailSeries(int id) async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getDetailSeries.execute(id);
    final resultRecom = await getSeriesRecommendations.execute(id);

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
        notifyListeners();
      },
      (seriesData) {
        _stateRecom = RequestState.loading;
        notifyListeners();
        notifyListeners();
        resultRecom.fold(
          (failure) {
            _message = failure.message;
            _state = RequestState.error;
            notifyListeners();
          },
          (recomData) {
            _seriesRecom = recomData;
            _state = RequestState.loaded;
            notifyListeners();
          },
        );
        _series = seriesData;
        _state = RequestState.loaded;
      },
    );
  }
}
