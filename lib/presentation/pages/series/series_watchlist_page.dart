import 'package:ditonton/presentation/bloc/series/states/watchlist_series_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/utils.dart';
import '../../bloc/series/blocs/watchlist_series_bloc.dart';
import '../../bloc/series/events/watchlist_series_event.dart';
import '../../widgets/series_card_list.dart';
import '../main_drawer.dart';

class WatchlistTvSeriesPage extends StatefulWidget {
  @override
  _WatchlistTvSeriesPageState createState() => _WatchlistTvSeriesPageState();
}

class _WatchlistTvSeriesPageState extends State<WatchlistTvSeriesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<WatchlistSeriesBloc>().add(OnWatchlistSeriesCalled());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    context.read<WatchlistSeriesBloc>().add(OnWatchlistSeriesCalled());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistSeriesBloc, WatchlistSeriesState>(
          builder: (context, state) {
            if (state is WatchlistSeriesLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WatchlistSeriesHasData) {
              final fetchSeriesWatchlist = state.result;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final watchlist = fetchSeriesWatchlist[index];
                  return SeriesCard(watchlist);
                },
                itemCount: fetchSeriesWatchlist.length,
              );
            } else if (state is WatchlistSeriesEmpty) {
              return addMore();
            } else {
              return Center(
                key: Key('error_message'),
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
            "You don't have whistlist of Series yet, you can add First",
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
