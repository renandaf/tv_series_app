import 'package:flutter/foundation.dart';
import 'package:tv_series_app/common/enum.dart';
import 'package:tv_series_app/domain/entities/detail.dart';
import 'package:tv_series_app/domain/entities/series.dart';
import 'package:tv_series_app/domain/usecases/get_series_detail.dart';
import 'package:tv_series_app/domain/usecases/get_series_recommendations.dart';

class DetailSeriesNotifier extends ChangeNotifier {
  final GetSeriesDetail getDetailSeries;
  final GetSeriesRecommendations getSeriesRecommendations;

  DetailSeriesNotifier(
      {required this.getDetailSeries, required this.getSeriesRecommendations});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  RequestState _stateRecom = RequestState.Empty;
  RequestState get stateRecom => _stateRecom;

  late Detail _series;
  Detail get series => _series;

  List<Series> _seriesRecom = [];
  List<Series> get seriesRecom => _seriesRecom;

  String _message = '';
  String get message => _message;

  Future<void> fetchDetailSeries(int id) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getDetailSeries.execute(id);
    final resultRecom = await getSeriesRecommendations.execute(id);

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (seriesData) {
        _stateRecom = RequestState.Loading;
        notifyListeners();
        notifyListeners();
        resultRecom.fold(
          (failure) {
            _message = failure.message;
            _state = RequestState.Error;
            notifyListeners();
          },
          (RecomData) {
            _seriesRecom = RecomData;
            _state = RequestState.Loaded;
            notifyListeners();
          },
        );
        _series = seriesData;
        _state = RequestState.Loaded;
      },
    );
  }
}
