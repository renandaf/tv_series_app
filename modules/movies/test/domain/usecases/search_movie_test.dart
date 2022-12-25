import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/domain/usecases/search_movies.dart';

import '../../dummy_data/dummy_object.dart';
import '../../helpers/test_helpers.mocks.dart';

void main() {
  late SearchMovies usecase;
  late MockMovieRepository mockRepository;

  setUp(() {
    mockRepository = MockMovieRepository();
    usecase = SearchMovies(mockRepository);
  });

  group('SearchMovies Tests', () {
    group('execute', () {
      test(
          'should get list of series from the repository when execute function is called',
          () async {
        // arrange
        when(mockRepository.searchMovies("w"))
            .thenAnswer((_) async => Right(testMovieList));
        // act
        final result = await usecase.execute("w");
        // assert
        expect(result, Right(testMovieList));
      });
    });
  });
}
