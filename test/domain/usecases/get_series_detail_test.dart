import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series_app/domain/usecases/get_series_detail.dart';

import '../../dummy_data/dummy_object.dart';
import '../../helpers/test_helpers.mocks.dart';

void main() {
  late GetSeriesDetail usecase;
  late MockSeriesRepository mockSeriesRpository;

  setUp(() {
    mockSeriesRpository = MockSeriesRepository();
    usecase = GetSeriesDetail(mockSeriesRpository);
  });

  group('GetDetailSeries Tests', () {
    const id = 1;
    group('execute', () {
      test(
          'should get detail of series from the repository when execute function is called',
          () async {
        // arrange
        when(mockSeriesRpository.getSeriesDetail(id))
            .thenAnswer((_) async => Right(detail));
        // act
        final result = await usecase.execute(id);
        // assert
        expect(result, Right(detail));
      });
    });
  });
}
