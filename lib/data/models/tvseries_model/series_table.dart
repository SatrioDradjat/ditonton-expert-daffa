// ignore_for_file: camel_case_types

import 'package:ditonton/domain/entities/tvSeries/series_detail.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/tvSeries/series_disp.dart';

class tvSeriesTable extends Equatable {
  final int id;
  final String? name;
  final String? posterPath;
  final String? overview;

  tvSeriesTable({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.overview,
  });

  factory tvSeriesTable.fromEntity(SeriesDetail tvSeries) => tvSeriesTable(
        id: tvSeries.id,
        name: tvSeries.name,
        posterPath: tvSeries.posterPath,
        overview: tvSeries.overview,
      );

  factory tvSeriesTable.fromMap(Map<String, dynamic> map) => tvSeriesTable(
        id: map['id'],
        name: map['name'],
        posterPath: map['posterPath'],
        overview: map['overview'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'posterPath': posterPath,
        'overview': overview,
      };

  Series toEntity() => Series.watchlist(
      id: id, overview: overview, posterPath: posterPath, name: name);

  @override
  List<Object?> get props => [id, name, posterPath, overview];
}
