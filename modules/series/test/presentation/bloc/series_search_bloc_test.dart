import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:series/series.dart';

import '../../dummy_data/dummy_object.dart';
import 'series_search_bloc_test.mocks.dart';

@GenerateMocks([SearchSeries])
void main() {
  late MockSearchSeries mockRepository;
  late SearchSeriesBloc bloc;

  setUp(() {
    mockRepository = MockSearchSeries();
    bloc = SearchSeriesBloc(mockRepository);
  });

  const query = "w";

  test(
    'initial state should be empty',
    () {
      expect(bloc.state, SeriesEmpty());
    },
  );

  blocTest<SearchSeriesBloc, SeriesState>(
    'emits [Loading, HasData] when data is gotten successfully.',
    build: () {
      when(mockRepository.execute(query))
          .thenAnswer((realInvocation) async => Right(seriesList));
      return bloc;
    },
    act: (bloc) => bloc.add(const OnQuerySeriesChanged(query)),
    wait: const Duration(milliseconds: 500),
    expect: () => <SeriesState>[
      SeriesLoading(),
      SeriesListHasData(seriesList),
    ],
    verify: (bloc) {
      verify(mockRepository.execute(query));
    },
  );

  blocTest<SearchSeriesBloc, SeriesState>(
    'emits [Loading, HasData] when data is gotten successfully.',
    build: () {
      when(mockRepository.execute(query)).thenAnswer((realInvocation) async =>
          const Left(ServerFailure('Server Failure')));
      return bloc;
    },
    act: (bloc) => bloc.add(const OnQuerySeriesChanged(query)),
    wait: const Duration(milliseconds: 500),
    expect: () => <SeriesState>[
      SeriesLoading(),
      const SeriesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockRepository.execute(query));
    },
  );
}
