import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:series/domain/usecases/get_top_rated_series.dart';

import '../../dummy_data/dummy_object.dart';
import '../../helpers/test_helpers.mocks.dart';

void main() {
  late GetTopRatedSeries usecase;
  late MockSeriesRepository mockSeriesRpository;

  setUp(() {
    mockSeriesRpository = MockSeriesRepository();
    usecase = GetTopRatedSeries(mockSeriesRpository);
  });

  group('GetTopRatedSeries Tests', () {
    group('execute', () {
      test(
          'should get list of series from the repository when execute function is called',
          () async {
        // arrange
        when(mockSeriesRpository.getTopRatedSeries())
            .thenAnswer((_) async => Right(tSeries));
        // act
        final result = await usecase.execute();
        // assert
        expect(result, Right(tSeries));
      });
    });
  });
}
