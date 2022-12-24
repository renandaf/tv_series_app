import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/domain/usecases/search_series.dart';

class SearchSeriesNotifier extends ChangeNotifier {
  final SearchSeries getSearchSeries;

  SearchSeriesNotifier(this.getSearchSeries);

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  List<Series> _series = [];
  List<Series> get series => _series;

  String _message = '';
  String get message => _message;

  Future<void> fetchSearchSeries(String query) async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getSearchSeries.execute(query);

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
        notifyListeners();
      },
      (seriesData) {
        _series = seriesData;
        _state = RequestState.loaded;
        notifyListeners();
      },
    );
  }
}
