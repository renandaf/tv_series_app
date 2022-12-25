import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/movies.dart';

import '../../dummy_data/dummy_object.dart';
import 'movie_recom_bloc_test.mocks.dart';

@GenerateMocks([GetMovieRecommendations])
void main() {
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MovieRecommendationBloc bloc;

  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    bloc = MovieRecommendationBloc(mockGetMovieRecommendations);
  });

  const int id = 1;

  test(
    'initial state should be empty',
    () {
      expect(bloc.state, MovieEmpty());
    },
  );

  blocTest<MovieRecommendationBloc, MovieState>(
    'emits [Loading, HasData] when data is gotten successfully.',
    build: () {
      when(mockGetMovieRecommendations.execute(id))
          .thenAnswer((realInvocation) async => Right(testMovieList));
      return bloc;
    },
    act: (bloc) => bloc.add(const OnMovieRecommendation(id)),
    expect: () => <MovieState>[
      MovieLoading(),
      MovieListHasData(testMovieList),
    ],
    verify: (bloc) {
      verify(mockGetMovieRecommendations.execute(id));
    },
  );

  blocTest<MovieRecommendationBloc, MovieState>(
    'emits [Loading, HasData] when data is gotten successfully.',
    build: () {
      when(mockGetMovieRecommendations.execute(id)).thenAnswer(
          (realInvocation) async =>
              const Left(ServerFailure('Server Failure')));
      return bloc;
    },
    act: (bloc) => bloc.add(const OnMovieRecommendation(id)),
    expect: () => <MovieState>[
      MovieLoading(),
      const MovieError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetMovieRecommendations.execute(id));
    },
  );
}
