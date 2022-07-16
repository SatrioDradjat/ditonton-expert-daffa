// ignore_for_file: non_constant_identifier_names, must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/genre.dart';

import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/presentation/bloc/movie/blocs/recommend_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/blocs/watchlist_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/events/watchlist_movie_event.dart';
import 'package:ditonton/presentation/bloc/movie/states/movie_detail_state.dart';
import 'package:ditonton/presentation/bloc/movie/states/recommend_movie_state.dart';
import 'package:ditonton/presentation/bloc/movie/states/watchlist_movie_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../bloc/movie/blocs/movie_detail_bloc.dart';
import '../bloc/movie/events/movie_detail_event.dart';
import '../bloc/movie/events/recommend_movie_event.dart';

class MovieDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail';

  final int id;
  MovieDetailPage({required this.id});

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<DetailMovieBloc>().add(OnDetailMovieCalled(widget.id));
      context
          .read<RecommendationMovieBloc>()
          .add(OnMovieRecommendationsCalled(widget.id));
      context.read<WatchlistMoviesBloc>().add(FetchWatchlist(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    final MovieAddToWatchlist =
        context.select<WatchlistMoviesBloc, bool>((bloc) {
      if (bloc.state is MovieIsAdded) {
        return (bloc.state as MovieIsAdded).isAdded;
      }
      return false;
    });

    return Scaffold(
      body: BlocBuilder<DetailMovieBloc, DetailMovieState>(
        builder: (context, state) {
          if (state is DetailMovieLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is DetailMovieHasData) {
            final movie = state.result;
            return SafeArea(
              child: DetailContent(movie, MovieAddToWatchlist),
            );
          } else {
            return Text('Failed To Fetch');
          }
        },
      ),
    );
  }
}

class DetailContent extends StatefulWidget {
  final MovieDetail detail;
  late bool addContent;

  DetailContent(this.detail, this.addContent);

  @override
  State<DetailContent> createState() => _DetailContentState();
}

class _DetailContentState extends State<DetailContent> {
  @override
  Widget build(BuildContext context) {
    void _watchlist() {
      if (!widget.addContent) {
        context.read<WatchlistMoviesBloc>().add(AddMovie(widget.detail));
      } else {
        context.read<WatchlistMoviesBloc>().add(RemoveMovie(widget.detail));
      }

      const AddMessage = 'Movie Added to Watchlist';
      const RemoveMessage = 'Movie Removed to Watchlist';
      String message = '';
      final state = BlocProvider.of<WatchlistMoviesBloc>(context).state;
      if (state is MovieIsAdded) {
        final isAdded = state.isAdded;
        message = isAdded == false ? AddMessage : RemoveMessage;
      } else {
        message = !widget.addContent ? AddMessage : RemoveMessage;
      }

      if (message == AddMessage || message == RemoveMessage) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(message),
          duration: const Duration(
            seconds: 1,
          ),
        ));
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(message),
              );
            });
      }
      setState(() {
        widget.addContent = !widget.addContent;
      });
    }

    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl:
              'https://image.tmdb.org/t/p/w500${widget.detail.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.detail.title,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                _watchlist();
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  widget.addContent
                                      ? Icon(Icons.check)
                                      : Icon(Icons.add),
                                  Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              _showGenres(widget.detail.genres),
                            ),
                            Text(
                              _showDuration(widget.detail.runtime),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: widget.detail.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${widget.detail.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              widget.detail.overview,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<RecommendationMovieBloc,
                                RecommendationMovieState>(
                              builder: (context, state) {
                                if (state is RecommendationMovieLoading) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is RecommendationMovieError) {
                                  return Text(state.message);
                                } else if (state
                                    is RecommendationMovieHasData) {
                                  final showRecommends = state.result;
                                  return Container(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final movie = showRecommends[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                MovieDetailPage.ROUTE_NAME,
                                                arguments: movie.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                                placeholder: (context, url) =>
                                                    Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: showRecommends.length,
                                    ),
                                  );
                                } else if (state is RecommendationMovieEmpty) {
                                  return Center(
                                    child: Text(
                                      'Movie Recommendation is not available',
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            minChildSize: 0.25,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
