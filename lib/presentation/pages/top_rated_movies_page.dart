import 'package:ditonton/presentation/bloc/movie/blocs/top_rated_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/events/top_rated_movie_event.dart';
import 'package:ditonton/presentation/bloc/movie/states/top_rated_movie_state.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRatedMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-movie';

  @override
  _TopRatedMoviesPageState createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TopRatedMovieBloc>().add(OnMovieTopRatedCalled());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedMovieBloc, TopRatedMovieState>(
          builder: (context, state) {
            if (state is TopRatedMovieLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TopRatedMovieHasData) {
              final fetchTopRated = state.result;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final topRatedList = fetchTopRated[index];
                  return MovieCard(topRatedList);
                },
                itemCount: fetchTopRated.length,
              );
            } else {
              return Center(
                child: Text('Failed to Fetch'),
              );
            }
          },
        ),
      ),
    );
  }
}
