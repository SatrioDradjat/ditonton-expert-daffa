import 'package:equatable/equatable.dart';
import '../../../../domain/entities/tvSeries/series_disp.dart';

abstract class OnTheAirSeriesState extends Equatable {}

class OnTheAirSeriesEmpty extends OnTheAirSeriesState {
  @override
  List<Object?> get props => [];
}

class OnTheAirSeriesLoading extends OnTheAirSeriesState {
  @override
  List<Object?> get props => [];
}

class OnTheAirSeriesHasData extends OnTheAirSeriesState {
  final List<Series> result;
  OnTheAirSeriesHasData(this.result);
  @override
  List<Object?> get props => [result];
}

class OnTheAirSeriesError extends OnTheAirSeriesState {
  final String message;
  OnTheAirSeriesError(this.message);
  @override
  List<Object?> get props => [message];
}
