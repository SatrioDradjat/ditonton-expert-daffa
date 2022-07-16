import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/bloc/movie/blocs/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/blocs/now_playing_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/blocs/popular_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/blocs/recommend_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/blocs/top_rated_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/blocs/watchlist_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/search/movie/search_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/search/series/search_series_bloc.dart';
import 'package:ditonton/presentation/bloc/series/blocs/detail_series_bloc.dart';
import 'package:ditonton/presentation/bloc/series/blocs/on_the_air_series_bloc.dart';
import 'package:ditonton/presentation/bloc/series/blocs/popular_series_bloc.dart';
import 'package:ditonton/presentation/bloc/series/blocs/recommend_series_bloc.dart';
import 'package:ditonton/presentation/bloc/series/blocs/top_rated_series_bloc.dart';
import 'package:ditonton/presentation/bloc/series/blocs/watchlist_series_bloc.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/main_drawer.dart';
import 'package:ditonton/presentation/pages/main_watchlist.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:ditonton/presentation/pages/series/series_detail_page.dart';
import 'package:ditonton/presentation/pages/series/series_popular_page.dart';
import 'package:ditonton/presentation/pages/series/series_top_rated_page.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/ssl_pinning/ssl_pinning.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/injection.dart' as di;

import 'common/drawer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await HttpSSLPinning.init();
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // movie
        BlocProvider(
          create: (_) => di.locator<NowPlayingMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<DetailMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<RecommendationMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedMovieBloc>(),
        ),

        // series
        BlocProvider(
          create: (_) => di.locator<OnTheAirSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<DetailSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SeriesSearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<RecommendationSeriesBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: MainDrawer(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            // drawer
            case MainDrawer.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => MainDrawer());
            // movie
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            // series
            case PopularSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularSeriesPage());
            case TopRatedSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedSeriesPage());
            case SeriesDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                  builder: (_) => SeriesDetailPage(id: id), settings: settings);
            // pages
            case SearchPage.ROUTE_NAME:
              final activeDrawerState = settings.arguments as DrawerStateEnum;
              return CupertinoPageRoute(
                builder: (_) => SearchPage(
                  activeDrawerState: activeDrawerState,
                ),
              );
            case MainWatchList.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => MainWatchList());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
