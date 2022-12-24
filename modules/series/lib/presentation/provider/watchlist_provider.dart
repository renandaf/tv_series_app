import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:series/domain/entities/detail.dart';
import 'package:series/domain/usecases/add_watchlist.dart';
import 'package:series/domain/usecases/get_watchlist.dart';
import 'package:series/domain/usecases/get_watchlist_status.dart';
import 'package:series/domain/usecases/remove_watchlist.dart';

class WatchListNotifier extends ChangeNotifier {
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;
  final GetWatchlist getWatchlistSeries;

  WatchListNotifier(
      {required this.getWatchListStatus,
      required this.saveWatchlist,
      required this.removeWatchlist,
      required this.getWatchlistSeries});

  var _watchlistSeries = <Detail>[];
  List<Detail> get watchlistSeries => _watchlistSeries;

  var _watchlistState = RequestState.empty;
  RequestState get watchlistState => _watchlistState;

  late Detail _series;
  Detail get series => _series;

  final RequestState _state = RequestState.empty;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  bool _isAddedtoWatchlist = false;
  bool get isAddedToWatchlist => _isAddedtoWatchlist;

  Future<void> addWatchlist(Detail series) async {
    final result = await saveWatchlist.execute(series);
    notifyListeners();
    await result.fold(
      (failure) async {
        _message = failure.message;
        notifyListeners();
      },
      (successMessage) async {
        _message = successMessage;
        notifyListeners();
      },
    );

    await loadWatchlistStatus(series.id!);
  }

  Future<void> removeFromWatchlist(Detail series) async {
    final result = await removeWatchlist.execute(series);
    notifyListeners();
    await result.fold(
      (failure) async {
        _message = failure.message;
        notifyListeners();
      },
      (successMessage) async {
        _message = successMessage;
        notifyListeners();
      },
    );

    await loadWatchlistStatus(series.id!);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchListStatus.execute(id);
    _isAddedtoWatchlist = result;
    notifyListeners();
  }

  Future<void> fetchWatchlistSeries() async {
    _watchlistState = RequestState.loading;
    notifyListeners();

    final result = await getWatchlistSeries.execute();
    result.fold(
      (failure) {
        _watchlistState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (watchlistData) {
        _watchlistState = RequestState.loaded;
        _watchlistSeries = watchlistData;
        notifyListeners();
      },
    );
  }
}
