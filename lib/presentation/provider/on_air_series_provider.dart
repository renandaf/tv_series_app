import 'package:flutter/foundation.dart';
import 'package:tv_series_app/common/enum.dart';
import 'package:tv_series_app/domain/entities/series.dart';
import 'package:tv_series_app/domain/usecases/get_on_air_series.dart';

class OnAirSeriesNotifier extends ChangeNotifier {
  final GetOnAirSeries getOnAirSeries;

  OnAirSeriesNotifier(this.getOnAirSeries);

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Series> _series = [];
  List<Series> get series => _series;

  String _message = '';
  String get message => _message;

  Future<void> fetchOnAirSeries() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getOnAirSeries.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (seriesData) {
        _series = seriesData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
