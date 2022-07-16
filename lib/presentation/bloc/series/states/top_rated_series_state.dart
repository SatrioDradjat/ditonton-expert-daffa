import 'package:equatable/equatable.dart';
import '../../../../domain/entities/tvSeries/series_disp.dart';

abstract class TopRatedSeriesState extends Equatable {}

class TopRatedSeriesEmpty extends TopRatedSeriesState {
  @override
  List<Object?> get props => [];
}

class TopRatedSeriesLoading extends TopRatedSeriesState {
  @override
  List<Object?> get props => [];
}

class TopRatedSeriesHasData extends TopRatedSeriesState {
  final List<Series> result;
  TopRatedSeriesHasData(this.result);
  @override
  List<Object?> get props => [result];
}

class TopRatedSeriesError extends TopRatedSeriesState {
  final String message;
  TopRatedSeriesError(this.message);
  @override
  List<Object?> get props => [message];
}
