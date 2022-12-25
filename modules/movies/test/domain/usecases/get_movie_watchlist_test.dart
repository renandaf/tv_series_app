import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/domain/usecases/get_watchlist_movies.dart';
import 'package:series/domain/usecases/get_watchlist.dart';

import '../../dummy_data/dummy_object.dart';
import '../../helpers/test_helpers.mocks.dart';

void main() {
  late GetWatchlistMovies usecase;
  late MockMovieRepository mockSeriesRepository;

  setUp(() {
    mockSeriesRepository = MockMovieRepository();
    usecase = GetWatchlistMovies(mockSeriesRepository);
  });

  test('should get list of moviefrom the repository', () async {
    // arrange
    when(mockSeriesRepository.getWatchlistMovies())
        .thenAnswer((_) async => Right(testMovieListDetail));
    // act
    final result = await usecase.execute();
    // assert
    verify(mockSeriesRepository.getWatchlistMovies());
    expect(result, Right(testMovieListDetail));
  });
}
