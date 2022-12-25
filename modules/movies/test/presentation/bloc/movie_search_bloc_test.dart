import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/movies.dart';

import '../../dummy_data/dummy_object.dart';
import 'movie_search_bloc_test.mocks.dart';

@GenerateMocks([SearchMovies])
void main() {
  late MockSearchMovies mockSearchMovies;
  late SearchMovieBloc bloc;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    bloc = SearchMovieBloc(mockSearchMovies);
  });

  const String query = "w";

  test(
    'initial state should be empty',
    () {
      expect(bloc.state, MovieEmpty());
    },
  );

  blocTest<SearchMovieBloc, MovieState>(
    'emits [Loading, HasData] when data is gotten successfully.',
    build: () {
      when(mockSearchMovies.execute(query))
          .thenAnswer((realInvocation) async => Right(testMovieList));
      return bloc;
    },
    act: (bloc) => bloc.add(const OnQueryChanged(query)),
    expect: () => <MovieState>[
      MovieLoading(),
      MovieListHasData(testMovieList),
    ],
    verify: (bloc) {
      verify(mockSearchMovies.execute(query));
    },
  );

  blocTest<SearchMovieBloc, MovieState>(
    'emits [Loading, HasData] when data is gotten successfully.',
    build: () {
      when(mockSearchMovies.execute(query)).thenAnswer((realInvocation) async =>
          const Left(ServerFailure('Server Failure')));
      return bloc;
    },
    act: (bloc) => bloc.add(const OnQueryChanged(query)),
    expect: () => <MovieState>[
      MovieLoading(),
      const MovieError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchMovies.execute(query));
    },
  );
}
