import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:series/series.dart';

import '../../dummy_data/dummy_object.dart';
import 'series_detail_bloc_test.mocks.dart';

@GenerateMocks([GetSeriesDetail])
void main() {
  late MockGetSeriesDetail mockRepository;
  late SeriesDetailBloc bloc;

  setUp(() {
    mockRepository = MockGetSeriesDetail();
    bloc = SeriesDetailBloc(mockRepository);
  });

  const id = 1;

  test(
    'initial state should be empty',
    () {
      expect(bloc.state, SeriesEmpty());
    },
  );

  blocTest<SeriesDetailBloc, SeriesState>(
    'emits [Loading, HasData] when data is gotten successfully.',
    build: () {
      when(mockRepository.execute(id))
          .thenAnswer((realInvocation) async => Right(detail));
      return bloc;
    },
    act: (bloc) => bloc.add(const OnDetailSeries(id)),
    expect: () => <SeriesState>[
      SeriesLoading(),
      DetailHasData(detail),
    ],
    verify: (bloc) {
      verify(mockRepository.execute(id));
    },
  );

  blocTest<SeriesDetailBloc, SeriesState>(
    'emits [Loading, HasData] when data is gotten successfully.',
    build: () {
      when(mockRepository.execute(id)).thenAnswer((realInvocation) async =>
          const Left(ServerFailure('Server Failure')));
      return bloc;
    },
    act: (bloc) => bloc.add(const OnDetailSeries(id)),
    expect: () => <SeriesState>[
      SeriesLoading(),
      const SeriesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockRepository.execute(id));
    },
  );
}
