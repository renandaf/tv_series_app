import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:series/domain/entities/season.dart';
import 'package:series/domain/usecases/get_season.dart';

class SeasonDetailNotifier extends ChangeNotifier {
  final GetSeason getSeason;

  SeasonDetailNotifier(this.getSeason);

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  late Season _season;
  Season get season => _season;

  String _message = '';
  String get message => _message;

  Future<void> fetchSeason(int id, int season) async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getSeason.execute(id, season);

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
        notifyListeners();
      },
      (seasonData) {
        _season = seasonData;
        _state = RequestState.loaded;
        notifyListeners();
      },
    );
  }
}
