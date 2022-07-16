import 'package:equatable/equatable.dart';
import '../../../../domain/entities/tvSeries/series_disp.dart';

abstract class WatchlistSeriesState extends Equatable {}

class WatchlistSeriesEmpty extends WatchlistSeriesState {
  @override
  List<Object?> get props => [];
}

class WatchlistSeriesLoading extends WatchlistSeriesState {
  @override
  List<Object?> get props => [];
}

class WatchlistSeriesError extends WatchlistSeriesState {
  final String message;
  WatchlistSeriesError(this.message);
  @override
  List<Object?> get props => [message];
}

class WatchlistSeriesHasData extends WatchlistSeriesState {
  final List<Series> result;
  WatchlistSeriesHasData(this.result);
  @override
  List<Object?> get props => [result];
}

class SeriesIsAdded extends WatchlistSeriesState {
  final bool isAdded;
  SeriesIsAdded(this.isAdded);
  @override
  List<Object?> get props => [isAdded];
}

class WatchlistSeriesMessage extends WatchlistSeriesState {
  final String message;
  WatchlistSeriesMessage(this.message);
  @override
  List<Object?> get props => [message];
}
