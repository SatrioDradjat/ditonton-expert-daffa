import 'package:ditonton/data/models/tvseries_model/series_model.dart';
import 'package:equatable/equatable.dart';

class SeriesResponse extends Equatable {
  final List<SeriesModel> tvSeriesList;

  SeriesResponse({required this.tvSeriesList});

  factory SeriesResponse.fromJson(Map<String, dynamic> json) =>
      SeriesResponse(
        tvSeriesList: List<SeriesModel>.from((json["results"] as List)
            .map((x) => SeriesModel.fromJson(x))
            .where((element) => element.posterPath != null)),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(tvSeriesList.map((x) => x.toJson())),
      };

  @override
  List<Object> get props => [tvSeriesList];
}
