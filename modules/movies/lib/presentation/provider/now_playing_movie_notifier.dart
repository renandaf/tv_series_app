import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/get_now_playing_movies.dart';

class NowPlayingMovieNotifier extends ChangeNotifier {
  final GetNowPlayingMovies getNowPlaying;

  NowPlayingMovieNotifier(this.getNowPlaying);

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  List<Movie> _movie = [];
  List<Movie> get movie => _movie;

  String _message = '';
  String get message => _message;

  Future<void> fetchNowPlayingMovies() async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getNowPlaying.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
        notifyListeners();
      },
      (seriesData) {
        _movie = seriesData;
        _state = RequestState.loaded;
        notifyListeners();
      },
    );
  }
}
