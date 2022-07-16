part of 'search_series_bloc.dart';

abstract class SeriesSearchState extends Equatable {
  const SeriesSearchState();

  @override
  List<Object> get props => [];
}

class SeriesSearchEmpty extends SeriesSearchState {}

class SeriesSearchLoading extends SeriesSearchState {}

class SeriesSearchError extends SeriesSearchState {
  final String message;

  const SeriesSearchError(this.message);

  @override
  List<Object> get props => [message];
}

class SeriesSearchHasData extends SeriesSearchState {
  final List<Series> result;

  const SeriesSearchHasData(this.result);

  @override
  List<Object> get props => [result];
}
