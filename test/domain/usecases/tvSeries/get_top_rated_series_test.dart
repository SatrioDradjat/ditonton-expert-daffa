import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tvSeries/series_disp.dart';
import 'package:ditonton/domain/usecases/tvSeries/get_top_rated_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTopRatedSeries usecase;
  late MockSeriesRepository mockSeriesRepository;

  setUp(() {
    mockSeriesRepository = MockSeriesRepository();
    usecase = GetTopRatedSeries(mockSeriesRepository);
  });

  final tSeries = <Series>[];

  group('Get Top Rated Series Tests', () {
    group('execute', () {
      test(
          'should get list of Series from the repository when execute function is called',
          () async {
        // arrange
        when(mockSeriesRepository.getTopRatedSeries())
            .thenAnswer((_) async => Right(tSeries));
        // act
        final result = await usecase.execute();
        // assert
        expect(result, Right(tSeries));
      });
    });
  });
}
