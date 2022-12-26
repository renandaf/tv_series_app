import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:series/domain/usecases/get_season.dart';

import '../../dummy_data/dummy_object.dart';
import '../../helpers/test_helpers.mocks.dart';

void main() {
  late GetSeason usecase;
  late MockSeriesRepository mockSeriesRpository;

  setUp(() {
    mockSeriesRpository = MockSeriesRepository();
    usecase = GetSeason(mockSeriesRpository);
  });

  group('GetSeasonDetail Tests', () {
    const id = 1;
    const season = 1;
    group('execute', () {
      test(
          'should get detail of season from the repository when execute function is called',
          () async {
        // arrange
        when(mockSeriesRpository.getSeasonDetail(id, season))
            .thenAnswer((_) async => const Right(testSeason));
        // act
        final result = await usecase.execute(id, season);
        // assert
        expect(result, const Right(testSeason));
      });
    });
  });
}
