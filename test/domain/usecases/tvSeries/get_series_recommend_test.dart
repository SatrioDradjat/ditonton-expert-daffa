import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tvSeries/series_disp.dart';
import 'package:ditonton/domain/usecases/tvSeries/get_recomendation_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetRecommendationsSeries usecase;
  late MockSeriesRepository mockSeriesRepository;

  setUp(() {
    mockSeriesRepository = MockSeriesRepository();
    usecase = GetRecommendationsSeries(mockSeriesRepository);
  });

  final tId = 1;
  final tSeries = <Series>[];

  test('should get list of Series Recommendations from the repository',
      () async {
    // arrange
    when(mockSeriesRepository.getSeriesRecommendations(tId))
        .thenAnswer((_) async => Right(tSeries));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(tSeries));
  });
}
