import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:series/domain/usecases/get_on_air_series.dart';

import '../../dummy_data/dummy_object.dart';
import '../../helpers/test_helpers.mocks.dart';

void main() {
  late GetOnAirSeries usecase;
  late MockSeriesRepository mockSeriesRpository;

  setUp(() {
    mockSeriesRpository = MockSeriesRepository();
    usecase = GetOnAirSeries(mockSeriesRpository);
  });

  group('GetOnAirSeries Tests', () {
    group('execute', () {
      test(
          'should get list of series from the repository when execute function is called',
          () async {
        // arrange
        when(mockSeriesRpository.getOnAirSeries())
            .thenAnswer((_) async => Right(tSeries));
        // act
        final result = await usecase.execute();
        // assert
        expect(result, Right(tSeries));
      });
    });
  });
}
