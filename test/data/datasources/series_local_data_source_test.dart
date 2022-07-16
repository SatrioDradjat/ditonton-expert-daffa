import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/datasource_tvseries/series_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SeriesLocalDataSourceImpl dataSource;
  late MockDatabaseHelperSeries mockDatabaseHelperSeries;

  setUp(() {
    mockDatabaseHelperSeries = MockDatabaseHelperSeries();
    dataSource =
        SeriesLocalDataSourceImpl(databaseHelper: mockDatabaseHelperSeries);
  });

  group('save Series watchlist', () {
    test('should return success message when insert to database is success',
        () async {
      // arrange
      when(mockDatabaseHelperSeries.insertSeriesWatchlist(testSeriesTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.insertSeriesWatchlist(testSeriesTable);
      // assert
      expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      // arrange
      when(mockDatabaseHelperSeries.insertSeriesWatchlist(testSeriesTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.insertSeriesWatchlist(testSeriesTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove Series watchlist', () {
    test('should return success message when remove from database is success',
        () async {
      // arrange
      when(mockDatabaseHelperSeries.removeWatchlist(testSeriesTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.removeWatchlist(testSeriesTable);
      // assert
      expect(result, 'Removed from Watchlist');
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(mockDatabaseHelperSeries.removeWatchlist(testSeriesTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.removeWatchlist(testSeriesTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get Series Detail By Id', () {
    final tId = 1;
    test('should return Series Detail Table when data is found', () async {
      // arrange
      when(mockDatabaseHelperSeries.getSeriesById(tId))
          .thenAnswer((_) async => testSeriesMap);
      // act
      final result = await dataSource.getSeriesById(tId);
      // assert
      expect(result, testSeriesTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockDatabaseHelperSeries.getSeriesById(tId))
          .thenAnswer((_) async => null);
      // act
      final result = await dataSource.getSeriesById(tId);
      // assert
      expect(result, null);
    });
  });

  group('get watchlist Series', () {
    test('should return list of SeriesTable from database', () async {
      // arrange
      when(mockDatabaseHelperSeries.getSeriesWatchlist())
          .thenAnswer((_) async => [testSeriesMap]);
      // act
      final result = await dataSource.getSeriesWatchlist();
      // assert
      expect(result, [testSeriesTable]);
    });
  });
}