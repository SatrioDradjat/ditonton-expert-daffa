// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/tvSeries/get_on_the_air_series.dart';
import 'package:ditonton/presentation/bloc/series/blocs/on_the_air_series_bloc.dart';
import 'package:ditonton/presentation/bloc/series/events/on_the_air_series_event.dart';
import 'package:ditonton/presentation/bloc/series/states/on_the_air_series_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'on_the_air_series_bloc_test.mocks.dart';

@GenerateMocks([GetOnTheAirSeries])
void main() {
  late MockGetOnTheAirSeries mockGetOnTheAirSeries;
  late OnTheAirSeriesBloc onTheAirSeries;

  setUp(() {
    mockGetOnTheAirSeries = MockGetOnTheAirSeries();
    onTheAirSeries = OnTheAirSeriesBloc(mockGetOnTheAirSeries);
  });

  blocTest<OnTheAirSeriesBloc, OnTheAirSeriesState>(
      'should emit Loading and Detail HasData',
      build: () {
        when(mockGetOnTheAirSeries.execute())
            .thenAnswer((_) async => Right(testSeriesList));
        return onTheAirSeries;
      },
      act: (bloc) => bloc.add(OnTheAirSeries()),
      expect: () => <OnTheAirSeriesState>[
            OnTheAirSeriesLoading(),
            OnTheAirSeriesHasData(testSeriesList)
          ],
      verify: (bloc) {
        verify(mockGetOnTheAirSeries.execute());
        return OnTheAirSeries().props;
      });

  blocTest<OnTheAirSeriesBloc, OnTheAirSeriesState>(
      'should emit Loading and Detail Error',
      build: () {
        when(mockGetOnTheAirSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server has Error')));
        return onTheAirSeries;
      },
      act: (bloc) => bloc.add(OnTheAirSeries()),
      expect: () => <OnTheAirSeriesState>[
            OnTheAirSeriesLoading(),
            OnTheAirSeriesError('Server has Error')
          ],
      verify: (bloc) {
        verify(mockGetOnTheAirSeries.execute());
        return OnTheAirSeries().props;
      });
}
