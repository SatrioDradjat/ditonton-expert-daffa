import 'package:equatable/equatable.dart';
import '../../../domain/entities/tvSeries/seasons.dart';

class SeasonModels extends Equatable {
  SeasonModels({
    required this.airDate,
    required this.episodeCount,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
  });

  final String? airDate;
  final int episodeCount;
  final int id;
  final String name;
  final String overview;
  final String? posterPath;
  final int seasonNumber;

  factory SeasonModels.fromJson(Map<String, dynamic> json) => SeasonModels(
        airDate: json["air_date"],
        episodeCount: json["episode_count"],
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        seasonNumber: json["season_number"],
      );

  Map<String, dynamic> toJson() => {
        "air_date": airDate,
        "episode_count": episodeCount,
        "id": id,
        "name": name,
        "overview": overview,
        "poster_path": posterPath,
        "season_number": seasonNumber,
      };

  Seasons toEntity() => Seasons(
        id: this.id,
        posterPath: this.posterPath,
        seasonNumber: this.seasonNumber,
        episodeCount: this.episodeCount,
      );

  @override
  List<Object?> get props => [
        this.airDate,
        this.episodeCount,
        this.id,
        this.name,
        this.overview,
        this.posterPath,
        this.seasonNumber
      ];
}
