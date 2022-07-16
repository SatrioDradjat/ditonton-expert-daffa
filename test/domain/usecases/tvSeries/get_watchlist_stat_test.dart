import 'package:ditonton/domain/usecases/tvSeries/get_watchlist_series_stat.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetWactchlistStatSeries usecase;
  late MockSeriesRepository mockSeriesRepository;

  setUp(() {
    mockSeriesRepository = MockSeriesRepository();
    usecase = GetWactchlistStatSeries(mockSeriesRepository);
  });

  test('should get list of Series from the repository', () async {
    // arrange
    when(mockSeriesRepository.isAddedToWatchlist(1))
        .thenAnswer((_) async => true);
    // act
    final result = await usecase.execute(1);
    // assert
    expect(result, true);
  });
}
