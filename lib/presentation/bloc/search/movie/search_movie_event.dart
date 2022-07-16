part of 'search_movie_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class MovieQueryChanged extends SearchEvent {
  final String query;

  const MovieQueryChanged(this.query);

  @override
  List<Object> get props => [query];
}
