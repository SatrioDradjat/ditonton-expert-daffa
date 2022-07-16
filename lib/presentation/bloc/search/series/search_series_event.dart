part of 'search_series_bloc.dart';

abstract class SearchEventSeries extends Equatable {
  const SearchEventSeries();

  @override
  List<Object> get props => [];
}

class SeriesQueryChanged extends SearchEventSeries {
  final String query;

  const SeriesQueryChanged(this.query);

  @override
  List<Object> get props => [query];
}
