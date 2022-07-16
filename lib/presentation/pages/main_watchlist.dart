import 'package:ditonton/presentation/pages/series/series_watchlist_page.dart';
import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:flutter/material.dart';

class MainWatchList extends StatelessWidget {
  const MainWatchList({Key? key}) : super(key: key);
  static const ROUTE_NAME = '/main-watchlist';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            new SliverAppBar(
              title: Text('Watchlist'),
              pinned: true,
              floating: true,
              bottom: TabBar(
                indicatorColor: Colors.white,
                tabs: [
                  _buildTabBarItem('Movies', Icons.movie),
                  _buildTabBarItem('Tv Series', Icons.tv),
                ],
              ),
            ),
          ];
        },
        body: TabBarView(
          children: <Widget>[
            WatchlistMoviesPage(),
            WatchlistTvSeriesPage(),
          ],
        ),
      )),
    );
  }

  Widget _buildTabBarItem(String title, IconData iconData) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10.0,
        bottom: 10.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(iconData),
          SizedBox(
            width: 12.0,
          ),
          Text(title),
        ],
      ),
    );
  }
}
