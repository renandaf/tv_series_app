import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:series/series.dart';
import '../../dummy_data/dummy_object.dart';
import 'on_air_series_bloc_test.mocks.dart';

@GenerateMocks([GetOnAirSeries])
void main() {
  late MockGetOnAirSeries mockRepository;
  late OnAirSeriesBloc bloc;

  setUp(() {
    mockRepository = MockGetOnAirSeries();
    bloc = OnAirSeriesBloc(mockRepository);
  });

  test(
    'initial state should be empty',
    () {
      expect(bloc.state, SeriesEmpty());
    },
  );

  blocTest<OnAirSeriesBloc, SeriesState>(
    'emits [Loading, HasData] when data is gotten successfully.',
    build: () {
      when(mockRepository.execute())
          .thenAnswer((realInvocation) async => Right(seriesList));
      return bloc;
    },
    act: (bloc) => bloc.add(OnOnAirSeries()),
    expect: () => <SeriesState>[
      SeriesLoading(),
      SeriesListHasData(seriesList),
    ],
    verify: (bloc) {
      verify(mockRepository.execute());
    },
  );

  blocTest<OnAirSeriesBloc, SeriesState>(
    'emits [Loading, HasData] when data is gotten successfully.',
    build: () {
      when(mockRepository.execute()).thenAnswer((realInvocation) async =>
          const Left(ServerFailure('Server Failure')));
      return bloc;
    },
    act: (bloc) => bloc.add(OnOnAirSeries()),
    expect: () => <SeriesState>[
      SeriesLoading(),
      const SeriesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockRepository.execute());
    },
  );
}
