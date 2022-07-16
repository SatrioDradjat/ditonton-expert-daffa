// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/tvSeries/get_top_rated_series.dart';
import 'package:ditonton/presentation/bloc/series/blocs/top_rated_series_bloc.dart';
import 'package:ditonton/presentation/bloc/series/events/top_rated_series_event.dart';
import 'package:ditonton/presentation/bloc/series/states/top_rated_series_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'top_rated_series_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedSeries])
void main() {
  late MockGetTopRatedSeries mockGetTopRatedSeries;
  late TopRatedSeriesBloc topRatedSeries;

  setUp(() {
    mockGetTopRatedSeries = MockGetTopRatedSeries();
    topRatedSeries = TopRatedSeriesBloc(mockGetTopRatedSeries);
  });

  blocTest<TopRatedSeriesBloc, TopRatedSeriesState>(
      'should emit Loading and Detail HasData',
      build: () {
        when(mockGetTopRatedSeries.execute())
            .thenAnswer((_) async => Right(testSeriesList));
        return topRatedSeries;
      },
      act: (bloc) => bloc.add(OnSeriesTopRatedCalled()),
      expect: () => <TopRatedSeriesState>[
            TopRatedSeriesLoading(),
            TopRatedSeriesHasData(testSeriesList)
          ],
      verify: (bloc) {
        verify(mockGetTopRatedSeries.execute());
        return OnSeriesTopRatedCalled().props;
      });

  blocTest<TopRatedSeriesBloc, TopRatedSeriesState>(
      'should emit Loading and Detail Error',
      build: () {
        when(mockGetTopRatedSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server has Error')));
        return topRatedSeries;
      },
      act: (bloc) => bloc.add(OnSeriesTopRatedCalled()),
      expect: () => <TopRatedSeriesState>[
            TopRatedSeriesLoading(),
            TopRatedSeriesError('Server has Error')
          ],
      verify: (bloc) {
        verify(mockGetTopRatedSeries.execute());
        return OnSeriesTopRatedCalled().props;
      });
}
