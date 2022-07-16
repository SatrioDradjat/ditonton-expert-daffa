// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/tvSeries/get_popular_series.dart';
import 'package:ditonton/presentation/bloc/series/blocs/popular_series_bloc.dart';
import 'package:ditonton/presentation/bloc/series/events/popular_series_event.dart';
import 'package:ditonton/presentation/bloc/series/states/popular_series_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'popular_series_bloc_test.mocks.dart';

@GenerateMocks([GetPopularSeries])
void main() {
  late MockGetPopularSeries mockGetPopularSeries;
  late PopularSeriesBloc popularSeries;

  setUp(() {
    mockGetPopularSeries = MockGetPopularSeries();
    popularSeries = PopularSeriesBloc(mockGetPopularSeries);
  });

  blocTest<PopularSeriesBloc, PopularSeriesState>(
      'should emit Loading and Detail HasData',
      build: () {
        when(mockGetPopularSeries.execute())
            .thenAnswer((_) async => Right(testSeriesList));
        return popularSeries;
      },
      act: (bloc) => bloc.add(OnPopularSeriesCalled()),
      expect: () => <PopularSeriesState>[
            PopularSeriesLoading(),
            PopularSeriesHasData(testSeriesList)
          ],
      verify: (bloc) {
        verify(mockGetPopularSeries.execute());
        return OnPopularSeriesCalled().props;
      });

  blocTest<PopularSeriesBloc, PopularSeriesState>(
      'should emit Loading and Detail Error',
      build: () {
        when(mockGetPopularSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server has Error')));
        return popularSeries;
      },
      act: (bloc) => bloc.add(OnPopularSeriesCalled()),
      expect: () => <PopularSeriesState>[
            PopularSeriesLoading(),
            PopularSeriesError('Server has Error')
          ],
      verify: (bloc) {
        verify(mockGetPopularSeries.execute());
        return OnPopularSeriesCalled().props;
      });
}
