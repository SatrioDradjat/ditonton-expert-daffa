import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tvSeries/series_disp.dart';
import 'package:ditonton/domain/usecases/tvSeries/get_on_the_air_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetOnTheAirSeries usecase;
  late MockSeriesRepository mockSeriesRepository;

  setUp(() {
    mockSeriesRepository = MockSeriesRepository();
    usecase = GetOnTheAirSeries(mockSeriesRepository);
  });

  final tSeries = <Series>[];

  test('should get list of Series On The Air from the repository', () async {
    // arrange
    when(mockSeriesRepository.getOnTheAirSeries())
        .thenAnswer((_) async => Right(tSeries));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tSeries));
  });
}
