import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/movies.dart';

import '../../dummy_data/dummy_object.dart';
import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([GetMovieDetail])
void main() {
  late MockGetMovieDetail mockGetMovieDetail;
  late MovieDetailBloc bloc;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    bloc = MovieDetailBloc(mockGetMovieDetail);
  });

  const int id = 1;

  test(
    'initial state should be empty',
    () {
      expect(bloc.state, MovieEmpty());
    },
  );

  blocTest<MovieDetailBloc, MovieState>(
    'emits [Loading, HasData] when data is gotten successfully.',
    build: () {
      when(mockGetMovieDetail.execute(id))
          .thenAnswer((realInvocation) async => Right(testMovieDetail));
      return bloc;
    },
    act: (bloc) => bloc.add(const OnDetailMovie(id)),
    expect: () => <MovieState>[
      MovieLoading(),
      MovieDetailHasData(testMovieDetail),
    ],
    verify: (bloc) {
      verify(mockGetMovieDetail.execute(id));
    },
  );

  blocTest<MovieDetailBloc, MovieState>(
    'emits [Loading, HasData] when data is gotten successfully.',
    build: () {
      when(mockGetMovieDetail.execute(id)).thenAnswer((realInvocation) async =>
          const Left(ServerFailure('Server Failure')));
      return bloc;
    },
    act: (bloc) => bloc.add(const OnDetailMovie(id)),
    expect: () => <MovieState>[
      MovieLoading(),
      const MovieError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetMovieDetail.execute(id));
    },
  );
}
