import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/bloc/movie/blocs/now_playing_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/blocs/popular_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/blocs/top_rated_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/events/now_playing_movie_event.dart';
import 'package:ditonton/presentation/bloc/movie/events/popular_movie_event.dart';
import 'package:ditonton/presentation/bloc/movie/events/top_rated_movie_event.dart';
import 'package:ditonton/presentation/bloc/movie/states/now_playing_movie_state.dart';
import 'package:ditonton/presentation/bloc/movie/states/popular_movie_state.dart';
import 'package:ditonton/presentation/bloc/movie/states/top_rated_movie_state.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeMoviePage extends StatefulWidget {
  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<NowPlayingMovieBloc>().add(OnNowPlayingMovie());
      context.read<PopularMovieBloc>().add(OnPopularMovieCalled());
      context.read<TopRatedMovieBloc>().add(OnMovieTopRatedCalled());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Now Playing',
              style: kHeading6,
            ),
            BlocBuilder<NowPlayingMovieBloc, NowPlayingMovieState>(
                builder: (context, state) {
              if (state is NowPlayingMovieLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is NowPlayingMovieHasData) {
                final fetchNowPlaying = state.result;
                return MovieList(fetchNowPlaying);
              } else {
                return Text('Failed to Fetch');
              }
            }),
            _buildSubHeading(
              title: 'Popular',
              onTap: () =>
                  Navigator.pushNamed(context, PopularMoviesPage.ROUTE_NAME),
            ),
            BlocBuilder<PopularMovieBloc, PopularMovieState>(
                builder: (context, state) {
              if (state is PopularMovieLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is PopularMovieHasData) {
                final fetchPopular = state.result;
                return MovieList(fetchPopular);
              } else {
                return Text('Failed to Fetch');
              }
            }),
            _buildSubHeading(
              title: 'Top Rated',
              onTap: () =>
                  Navigator.pushNamed(context, TopRatedMoviesPage.ROUTE_NAME),
            ),
            BlocBuilder<TopRatedMovieBloc, TopRatedMovieState>(
                builder: (context, state) {
              if (state is TopRatedMovieLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is TopRatedMovieHasData) {
                final fetchTopRated = state.result;
                return MovieList(fetchTopRated);
              } else {
                return Text('Failed to Fetch');
              }
            }),
          ],
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  MovieList(this.movies);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MovieDetailPage.ROUTE_NAME,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
