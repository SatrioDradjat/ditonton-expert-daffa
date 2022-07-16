import 'package:ditonton/data/models/tvseries_model/series_model.dart';
import 'package:ditonton/domain/entities/tvSeries/series_disp.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tSeriesModel = SeriesModel(
      backdropPath: "backdropPath",
      firstAirDate: "firstAirDate",
      genreIds: [1,2,3],
      id: 1,
      name: "name",
      originCountry: ["originCountry"],
      originalLanguage: "originalLanguage",
      originalName: "originalName",
      overview: "overview",
      popularity: 1,
      posterPath: "posterPath",
      voteAverage: 1,
      voteCount: 1);

  final tSeries = Series(
      backdropPath: "backdropPath",
      firstAirDate: "firstAirDate",
      genreIds: [1,2,3],
      id: 1,
      name: "name",
      originCountry: ["originCountry"],
      originalLanguage: "originalLanguage",
      originalName: "originalName",
      overview: "overview",
      popularity: 1,
      posterPath: "posterPath",
      voteAverage: 1,
      voteCount: 1);

  test('should be a subclass of Series entity', () async {
    final result = tSeriesModel.toEntity();
    expect(result, tSeries);
  });
}
