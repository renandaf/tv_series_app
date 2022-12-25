import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/domain/usecases/get_movie_recommendations.dart';

import '../../dummy_data/dummy_object.dart';
import '../../helpers/test_helpers.mocks.dart';

void main() {
  late GetMovieRecommendations usecase;
  late MockMovieRepository mockRepository;

  setUp(() {
    mockRepository = MockMovieRepository();
    usecase = GetMovieRecommendations(mockRepository);
  });

  group('GetMovieRecommendations Tests', () {
    group('execute', () {
      test(
          'should get list of series from the repository when execute function is called',
          () async {
        // arrange
        when(mockRepository.getMovieRecommendations(1))
            .thenAnswer((_) async => Right(testMovieList));
        // act
        final result = await usecase.execute(1);
        // assert
        expect(result, Right(testMovieList));
      });
    });
  });
}
