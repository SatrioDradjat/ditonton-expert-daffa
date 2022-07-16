import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/tvSeries/get_watchlist_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlistSeries usecase;
  late MockSeriesRepository mockSeriesRepository;

  setUp(() {
    mockSeriesRepository = MockSeriesRepository();
    usecase = GetWatchlistSeries(mockSeriesRepository);
  });

  group('Get Top Rated Series Tests', () {
    group('execute', () {
      test('should get list of Series from the repository', () async {
        // arrange
        when(mockSeriesRepository.getWatchlistTvSeries())
            .thenAnswer((_) async => Right(testSeriesListModel));
        // act
        final result = await usecase.execute();
        // assert
        expect(result, Right(testSeriesListModel));
      });
    });
  });
}
