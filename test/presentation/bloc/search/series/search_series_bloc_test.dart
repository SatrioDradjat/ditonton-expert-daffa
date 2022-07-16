// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tvSeries/series_disp.dart';
import 'package:ditonton/domain/usecases/tvSeries/search_series.dart';
import 'package:ditonton/presentation/bloc/search/series/search_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_series_bloc_test.mocks.dart';

@GenerateMocks([SearchWatchlistSeries])
void main() {
  late SeriesSearchBloc seriesSearchBloc;
  late MockSearchWatchlistSeries mockSearchWatchlistSeries;

  setUp(() {
    mockSearchWatchlistSeries = MockSearchWatchlistSeries();
    seriesSearchBloc = SeriesSearchBloc(mockSearchWatchlistSeries);
  });

  final testSeriesModel = Series(
      backdropPath: "/n6vVs6z8obNbExdD3QHTr4Utu1Z.jpg",
      firstAirDate: "2019-07-25",
      genreIds: [
        10765,
      ],
      id: 3435045,
      name: "The Boys",
      originCountry: ["us"],
      originalLanguage: "en",
      originalName: "The Boys",
      overview:
          "A group of vigilantes known informally as 'The Boys' set out to take down corrupt superheroes with no more than blue-collar grit and a willingness to fight dirty.",
      popularity: 4866.719,
      posterPath: "/stTEycfG9928HYGEISBFaG1ngjM.jpg",
      voteAverage: 8.4,
      voteCount: 6319);
  final tSeriesList = <Series>[testSeriesModel];
  const tQuery = 'The Boys';

  test('initial state should be empty', () {
    expect(seriesSearchBloc.state, SeriesSearchEmpty());
  });

  blocTest<SeriesSearchBloc, SeriesSearchState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockSearchWatchlistSeries.execute(tQuery))
          .thenAnswer((_) async => Right(tSeriesList));
      return seriesSearchBloc;
    },
    act: (bloc) => bloc.add(const SeriesQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SeriesSearchLoading(),
      SeriesSearchHasData(tSeriesList),
    ],
    verify: (bloc) {
      verify(mockSearchWatchlistSeries.execute(tQuery));
    },
  );

  blocTest<SeriesSearchBloc, SeriesSearchState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockSearchWatchlistSeries.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return seriesSearchBloc;
    },
    act: (bloc) => bloc.add(const SeriesQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SeriesSearchLoading(),
      const SeriesSearchError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchWatchlistSeries.execute(tQuery));
    },
  );
}
