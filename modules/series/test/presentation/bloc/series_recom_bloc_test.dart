import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:series/series.dart';

import '../../dummy_data/dummy_object.dart';
import 'series_recom_bloc_test.mocks.dart';

@GenerateMocks([GetSeriesRecommendations])
void main() {
  late MockGetSeriesRecommendations mockRepository;
  late SeriesRecommendationBloc bloc;

  setUp(() {
    mockRepository = MockGetSeriesRecommendations();
    bloc = SeriesRecommendationBloc(mockRepository);
  });

  const id = 1;

  test(
    'initial state should be empty',
    () {
      expect(bloc.state, SeriesEmpty());
    },
  );

  blocTest<SeriesRecommendationBloc, SeriesState>(
    'emits [Loading, HasData] when data is gotten successfully.',
    build: () {
      when(mockRepository.execute(id))
          .thenAnswer((realInvocation) async => Right(seriesList));
      return bloc;
    },
    act: (bloc) => bloc.add(const OnSeriesRecommendation(id)),
    expect: () => <SeriesState>[
      SeriesLoading(),
      SeriesListHasData(seriesList),
    ],
    verify: (bloc) {
      verify(mockRepository.execute(id));
    },
  );

  blocTest<SeriesRecommendationBloc, SeriesState>(
    'emits [Loading, HasData] when data is gotten successfully.',
    build: () {
      when(mockRepository.execute(id)).thenAnswer((realInvocation) async =>
          const Left(ServerFailure('Server Failure')));
      return bloc;
    },
    act: (bloc) => bloc.add(const OnSeriesRecommendation(id)),
    expect: () => <SeriesState>[
      SeriesLoading(),
      const SeriesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockRepository.execute(id));
    },
  );
}
