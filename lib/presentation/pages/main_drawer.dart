import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/home_movie_page.dart';
import 'package:ditonton/presentation/pages/main_watchlist.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:ditonton/presentation/pages/series/series_home_page.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import '../../common/constants.dart';
import '../../common/drawer.dart';

class MainDrawer extends StatefulWidget {
  static const ROUTE_NAME = '/drawer';

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  DrawerStateEnum _activeDrawerState = DrawerStateEnum.Movies;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      drawer:
          _buildDrawerState(context, (DrawerStateEnum selectedDrawerNewState) {
        setState(() {
          setState(() {
            _activeDrawerState = selectedDrawerNewState;
          });
        });
      }, _activeDrawerState),
      appBar: _buildAppBarState(context, _activeDrawerState),
      body: _buildBodyState(context, _activeDrawerState),
    );
  }

  Drawer _buildDrawerState(
      BuildContext context,
      Function(DrawerStateEnum) stateCallback,
      DrawerStateEnum activeDrawerState) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/circle-g.png'),
            ),
            accountName: Text('Ditonton'),
            accountEmail: Text('ditonton@dicoding.com'),
          ),
          ListTile(
            tileColor: activeDrawerState == DrawerStateEnum.Movies
                ? kOxfordBlue
                : kGrey,
            leading: Icon(Icons.movie),
            title: Text('Movies'),
            onTap: () {
              Navigator.pop(context);
              stateCallback(DrawerStateEnum.Movies);
            },
          ),
          ListTile(
            tileColor: activeDrawerState == DrawerStateEnum.TvSeries
                ? kOxfordBlue
                : kGrey,
            leading: Icon(Icons.tv),
            title: Text('Tv Series'),
            onTap: () {
              Navigator.pop(context);
              stateCallback(DrawerStateEnum.TvSeries);
            },
          ),
          ListTile(
            leading: Icon(Icons.save_alt),
            title: Text('Watchlist'),
            onTap: () {
              Navigator.pushNamed(context, MainWatchList.ROUTE_NAME);
            },
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
            },
            leading: Icon(Icons.info_outline),
            title: Text('About'),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBarState(
      BuildContext context, DrawerStateEnum activeDrawerState) {
    return AppBar(
      title: Text(
          'Ditonton ${activeDrawerState == DrawerStateEnum.Movies ? 'Movies' : 'Tv Series'}'),
      actions: [
        IconButton(
          onPressed: () {
            // FirebaseCrashlytics.instance.crash();
            Navigator.pushNamed(context, SearchPage.ROUTE_NAME,
                arguments: activeDrawerState);
          },
          icon: Icon(Icons.search),
        )
      ],
    );
  }

  Widget _buildBodyState(
      BuildContext context, DrawerStateEnum selectedDrawerState) {
    if (selectedDrawerState == DrawerStateEnum.Movies) {
      return HomeMoviePage();
    } else if (selectedDrawerState == DrawerStateEnum.TvSeries) {
      return HomeSeriesPage();
    }
    return Container();
  }
}
