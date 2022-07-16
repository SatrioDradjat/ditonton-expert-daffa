import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/tvSeries/get_series_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetDetailSeries usecase;
  late MockSeriesRepository mockSeriesRepository;

  setUp(() {
    mockSeriesRepository = MockSeriesRepository();
    usecase = GetDetailSeries(mockSeriesRepository);
  });

  final tId = 1;

  test('should get list of Series from the repository', () async {
    // arrange
    when(mockSeriesRepository.getSeriesDetail(tId))
        .thenAnswer((_) async => Right(testSeriesDetailResponse));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(testSeriesDetailResponse));
  });
}
