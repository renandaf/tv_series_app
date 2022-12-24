import 'package:flutter/foundation.dart';
import 'package:tv_series_app/common/enum.dart';
import 'package:tv_series_app/domain/entities/series.dart';
import 'package:tv_series_app/domain/usecases/search_series.dart';

class SearchSeriesNotifier extends ChangeNotifier {
  final SearchSeries getSearchSeries;

  SearchSeriesNotifier(this.getSearchSeries);

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Series> _series = [];
  List<Series> get series => _series;

  String _message = '';
  String get message => _message;

  Future<void> fetchSearchSeries(String query) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getSearchSeries.execute(query);

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
