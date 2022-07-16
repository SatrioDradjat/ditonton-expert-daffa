import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/bloc/movie/blocs/watchlist_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/events/watchlist_movie_event.dart';
import 'package:ditonton/presentation/bloc/movie/states/watchlist_movie_state.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'main_drawer.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<WatchlistMoviesBloc>().add(OnWatchlistMovieCalled());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    context.read<WatchlistMoviesBloc>().add(OnWatchlistMovieCalled());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistMoviesBloc, WatchlistMovieState>(
          builder: (context, state) {
            if (state is WatchlistMovieLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WatchlistMovieHasData) {
              final fetchWatchListMovie = state.result;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final watchlist = fetchWatchListMovie[index];
                  return MovieCard(watchlist);
                },
                itemCount: fetchWatchListMovie.length,
              );
            } else if (state is WatchlistMovieEmpty) {
              return addMore();
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

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  Center addMore() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "You don't have whistlist of Movie yet, you can add First",
            textAlign: TextAlign.center,
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushNamedAndRemoveUntil(
              context,
              MainDrawer.ROUTE_NAME,
              (route) => false,
            ),
            child: Text('Add Whistlist'),
          ),
        ],
      ),
    );
  }
}
