import 'package:flutter/foundation.dart';
import 'package:tv_series_app/common/enum.dart';
import 'package:tv_series_app/domain/entities/movie.dart';
import 'package:tv_series_app/domain/usecases/get_now_playing_movies.dart';

class NowPlayingMovieNotifier extends ChangeNotifier {
  final GetNowPlayingMovies getNowPlaying;

  NowPlayingMovieNotifier(this.getNowPlaying);

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Movie> _movie = [];
  List<Movie> get movie => _movie;

  String _message = '';
  String get message => _message;

  Future<void> fetchNowPlayingMovies() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getNowPlaying.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (seriesData) {
        _movie = seriesData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
