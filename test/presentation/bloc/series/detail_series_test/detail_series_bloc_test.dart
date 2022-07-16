// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tvSeries/series_detail.dart';
import 'package:ditonton/domain/usecases/tvSeries/get_series_detail.dart';
import 'package:ditonton/presentation/bloc/series/blocs/detail_series_bloc.dart';
import 'package:ditonton/presentation/bloc/series/events/detail_series_event.dart';
import 'package:ditonton/presentation/bloc/series/states/detail_series_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'detail_series_bloc_test.mocks.dart';

final testSeriesDetail = SeriesDetail(
    backdropPath: "backdropPath",
    episodeRunTime: [],
    firstAirDate: "firstAirDate",
    genres: [
      Genre(
        id: 1,
        name: "Action & Adventure",
      )
    ],
    id: 1,
    name: "The Boys",
    numberOfEpisodes: 1,
    numberOfSeasons: 1,
    overview: "overview",
    posterPath: "posterPath",
    voteAverage: 1,
    voteCount: 1,
    seasons: []);

@GenerateMocks([GetDetailSeries])
void main() {
  late MockGetDetailSeries mockGetDetailSeries;
  late DetailSeriesBloc detailSeries;

  const tId = 1;
  setUp(() {
    mockGetDetailSeries = MockGetDetailSeries();
    detailSeries = DetailSeriesBloc(mockGetDetailSeries);
  });

  blocTest<DetailSeriesBloc, DetailSeriesState>(
      'should emit Loading and Detail HasData',
      build: () {
        when(mockGetDetailSeries.execute(tId))
            .thenAnswer((_) async => Right(testSeriesDetail));
        return detailSeries;
      },
      act: (bloc) => bloc.add(OnDetailSeriesCalled(tId)),
      expect: () => <DetailSeriesState>[
            DetailSeriesLoading(),
            DetailSeriesHasData(testSeriesDetail)
          ],
      verify: (bloc) {
        verify(mockGetDetailSeries.execute(tId));
        return OnDetailSeriesCalled(tId).props;
      });

  blocTest<DetailSeriesBloc, DetailSeriesState>(
      'should emit Loading and Detail Error',
      build: () {
        when(mockGetDetailSeries.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server has Error')));
        return detailSeries;
      },
      act: (bloc) => bloc.add(OnDetailSeriesCalled(tId)),
      expect: () => <DetailSeriesState>[
            DetailSeriesLoading(),
            DetailSeriesError('Server has Error')
          ],
      verify: (bloc) {
        verify(mockGetDetailSeries.execute(tId));
        return OnDetailSeriesCalled(tId).props;
      });

  test('should emit Loading and Detail Empty', () {
    expect(detailSeries.state, DetailSeriesEmpty());
  });
}
