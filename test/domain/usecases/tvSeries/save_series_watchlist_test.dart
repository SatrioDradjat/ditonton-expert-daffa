import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/tvSeries/save_watchlist_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late SaveWatchlistSeries usecase;
  late MockSeriesRepository mockSeriesRepository;

  setUp(() {
    mockSeriesRepository = MockSeriesRepository();
    usecase = SaveWatchlistSeries(mockSeriesRepository);
  });

  test('should Save watchlist Series from repository', () async {
    // arrange
    when(mockSeriesRepository.saveWatchlist(testSeriesDetailResponse))
        .thenAnswer((_) async => Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testSeriesDetailResponse);
    // assert
    verify(mockSeriesRepository.saveWatchlist(testSeriesDetailResponse));
    expect(result, Right('Removed from watchlist'));
  });
}
