import 'package:tv_series_app/domain/repositories/series_repository.dart';

class GetWatchListStatus {
  final SeriesRepository repository;

  GetWatchListStatus(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}
