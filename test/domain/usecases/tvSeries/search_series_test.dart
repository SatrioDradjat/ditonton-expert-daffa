import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tvSeries/series_disp.dart';
import 'package:ditonton/domain/usecases/tvSeries/search_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late SearchWatchlistSeries usecase;
  late MockSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockSeriesRepository();
    usecase = SearchWatchlistSeries(mockTvSeriesRepository);
  });

  final tSeries = <Series>[];
  final tQuery = 'The Boys';

  test('should get list of Series from the repository', () async {
    // arrange
    when(mockTvSeriesRepository.searchSeries(tQuery))
        .thenAnswer((_) async => Right(tSeries));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(tSeries));
  });
}
