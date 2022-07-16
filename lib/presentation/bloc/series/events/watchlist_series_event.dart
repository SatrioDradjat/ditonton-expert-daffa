import 'package:equatable/equatable.dart';
import '../../../../domain/entities/tvSeries/series_detail.dart';

abstract class WatchlistSeriesEvent extends Equatable {}

class OnWatchlistSeriesCalled extends WatchlistSeriesEvent {
  @override
  List<Object?> get props => [];
}

class FetchWatchlistSeries extends WatchlistSeriesEvent {
  final int id;
  FetchWatchlistSeries(this.id);
  @override
  List<Object?> get props => [id];
}

class AddSeries extends WatchlistSeriesEvent {
  final SeriesDetail seriesDetail;
  AddSeries(this.seriesDetail);
  @override
  List<Object?> get props => [seriesDetail];
}

class RemoveSeries extends WatchlistSeriesEvent {
  final SeriesDetail seriesDetail;
  RemoveSeries(this.seriesDetail);
  @override
  List<Object?> get props => [seriesDetail];
}
