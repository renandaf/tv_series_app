import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:series/series.dart';

import '../../dummy_data/dummy_object.dart';
import 'season_detail_bloc_test.mocks.dart';

@GenerateMocks([GetSeason])
void main() {
  late MockGetSeason mockRepository;
  late SeasonDetailBloc bloc;

  setUp(() {
    mockRepository = MockGetSeason();
    bloc = SeasonDetailBloc(mockRepository);
  });

  const id = 1;
  const season = 1;

  test(
    'initial state should be empty',
    () {
      expect(bloc.state, SeriesEmpty());
    },
  );

  blocTest<SeasonDetailBloc, SeriesState>(
    'emits [Loading, HasData] when data is gotten successfully.',
    build: () {
      when(mockRepository.execute(id, season))
          .thenAnswer((realInvocation) async => const Right(testSeason));
      return bloc;
    },
    act: (bloc) => bloc.add(const OnSeasonDetail(id, season)),
    expect: () => <SeriesState>[
      SeriesLoading(),
      const SeasonHasData(testSeason),
    ],
    verify: (bloc) {
      verify(mockRepository.execute(id, season));
    },
  );

  blocTest<SeasonDetailBloc, SeriesState>(
    'emits [Loading, HasData] when data is gotten successfully.',
    build: () {
      when(mockRepository.execute(id, season)).thenAnswer(
          (realInvocation) async =>
              const Left(ServerFailure('Server Failure')));
      return bloc;
    },
    act: (bloc) => bloc.add(const OnSeasonDetail(id, season)),
    expect: () => <SeriesState>[
      SeriesLoading(),
      const SeriesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockRepository.execute(id, season));
    },
  );
}
