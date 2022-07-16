import 'package:ditonton/presentation/bloc/movie/blocs/popular_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/events/popular_movie_event.dart';
import 'package:ditonton/presentation/bloc/movie/states/popular_movie_state.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-movie';

  @override
  _PopularMoviesPageState createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<PopularMovieBloc>().add(OnPopularMovieCalled());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularMovieBloc, PopularMovieState>(
          builder: (context, state) {
            if (state is PopularMovieLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularMovieHasData) {
              final fetchPopular = state.result;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final popularList = fetchPopular[index];
                  return MovieCard(popularList);
                },
                itemCount: fetchPopular.length,
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
