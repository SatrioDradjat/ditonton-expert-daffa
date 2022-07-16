import 'package:ditonton/common/constants.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/drawer.dart';
import '../bloc/search/movie/search_movie_bloc.dart';
import '../bloc/search/series/search_series_bloc.dart';
import '../widgets/series_card_list.dart';

class SearchPage extends StatelessWidget {
  static const ROUTE_NAME = '/search';

  late final DrawerStateEnum activeDrawerState;
  SearchPage({Key? key, required this.activeDrawerState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Search ${activeDrawerState == DrawerStateEnum.Movies ? 'Movies' : 'Tv Series'}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (query) {
                if (activeDrawerState == DrawerStateEnum.Movies) {
                  context.read<SearchBloc>().add(MovieQueryChanged(query));
                } else if (activeDrawerState == DrawerStateEnum.TvSeries) {
                  context
                      .read<SeriesSearchBloc>()
                      .add(SeriesQueryChanged(query));
                }
              },
              decoration: InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            if (activeDrawerState == DrawerStateEnum.Movies) searchMovie(),
            if (activeDrawerState == DrawerStateEnum.TvSeries) searchSeries(),
          ],
        ),
      ),
    );
  }

  Widget searchSeries() {
    return BlocBuilder<SeriesSearchBloc, SeriesSearchState>(
      builder: (context, state) {
        if (state is SeriesSearchLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is SeriesSearchHasData) {
          final result = state.result;
          return Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                final searchResult = result[index];
                return SeriesCard(searchResult);
              },
              itemCount: result.length,
            ),
          );
        } else {
          return Expanded(
            child: Container(),
          );
        }
      },
    );
  }

  Widget searchMovie() {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is SearchLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is SearchHasData) {
          final result = state.result;
          return Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                final searchResult = result[index];
                return MovieCard(searchResult);
              },
              itemCount: result.length,
            ),
          );
        } else {
          return Expanded(
            child: Container(),
          );
        }
      },
    );
  }
}
