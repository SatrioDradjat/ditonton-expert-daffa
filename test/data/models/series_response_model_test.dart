import 'dart:convert';

import 'package:ditonton/data/models/tvseries_model/series_model.dart';
import 'package:ditonton/data/models/tvseries_model/series_response.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../json_reader.dart';

void main() {
  final tSeriesModel = SeriesModel(
      backdropPath: "/n6vVs6z8obNbExdD3QHTr4Utu1Z.jpg",
      firstAirDate: "2019-07-25",
      genreIds: [
        10765,
      ],
      id: 76479,
      name: "The Boys",
      originCountry: ["US"],
      originalLanguage: "en",
      originalName: "The Boys",
      overview:
          "A group of vigilantes known informally as 'The Boys' set out to take down corrupt superheroes with no more than blue-collar grit and a willingness to fight dirty.",
      popularity: 4866.719,
      posterPath: "/stTEycfG9928HYGEISBFaG1ngjM.jpg",
      voteAverage: 8.4,
      voteCount: 6319);

  final tSeriesResponseModel =
      SeriesResponse(tvSeriesList: <SeriesModel>[tSeriesModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/on_the_air.json'));
      // act
      final result = SeriesResponse.fromJson(jsonMap);
      // assert
      expect(result, tSeriesResponseModel);
    });
  });
}
