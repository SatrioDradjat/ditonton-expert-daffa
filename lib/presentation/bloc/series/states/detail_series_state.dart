import 'package:equatable/equatable.dart';
import '../../../../domain/entities/tvSeries/series_detail.dart';

abstract class DetailSeriesState extends Equatable {}

class DetailSeriesEmpty extends DetailSeriesState {
  @override
  List<Object?> get props => [];
}

class DetailSeriesLoading extends DetailSeriesState {
  @override
  List<Object?> get props => [];
}

class DetailSeriesHasData extends DetailSeriesState {
  final SeriesDetail result;
  DetailSeriesHasData(this.result);
  @override
  List<Object?> get props => [result];
}

class DetailSeriesError extends DetailSeriesState {
  final String message;
  DetailSeriesError(this.message);
  @override
  List<Object?> get props => [message];
}
