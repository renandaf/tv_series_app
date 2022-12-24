import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series_app/domain/usecases/search_series.dart';

import '../../dummy_data/dummy_object.dart';
import '../../helpers/test_helpers.mocks.dart';

void main() {
  late SearchSeries usecase;
  late MockSeriesRepository mockSeriesRepository;

  setUp(() {
    mockSeriesRepository = MockSeriesRepository();
    usecase = SearchSeries(mockSeriesRepository);
  });

  const query = "wednesday";
  test('should get list of series from the repository', () async {
    // arrange
    when(mockSeriesRepository.searchSeries(query))
        .thenAnswer((_) async => Right(tSeries));
    // act
    final result = await usecase.execute(query);
    // assert
    verify(mockSeriesRepository.searchSeries(query));
    expect(result, Right(tSeries));
  });
}
