import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/domain/usecases/remove_movie_watchlist.dart';

import '../../dummy_data/dummy_object.dart';
import '../../helpers/test_helpers.mocks.dart';

void main() {
  late RemoveMovieWatchlist usecase;
  late MockMovieRepository mockSeriesRepository;

  setUp(() {
    mockSeriesRepository = MockMovieRepository();
    usecase = RemoveMovieWatchlist(mockSeriesRepository);
  });

  test('should save movie to the repository', () async {
    // arrange
    when(mockSeriesRepository.removeWatchlist(testMovieDetail))
        .thenAnswer((_) async => const Right('Removed from Warchlist'));
    // act
    final result = await usecase.execute(testMovieDetail);
    // assert
    verify(mockSeriesRepository.removeWatchlist(testMovieDetail));
    expect(result, const Right('Removed from Warchlist'));
  });
}
