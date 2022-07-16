import 'dart:async';

import 'package:ditonton/data/models/tvseries_model/series_table.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelperSeries {
  static DatabaseHelperSeries? _databaseHelper;
  DatabaseHelperSeries._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelperSeries() => _databaseHelper ?? DatabaseHelperSeries._instance();

  Database? _database;

  Future<Database?> get database async {
    if (_database == null) {
      _database = await _initDb();
    }
    return _database;
  }

  String _tblSeriesWatchlist = 'series_watchlist';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/ditontontv.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblSeriesWatchlist (
        id INTEGER PRIMARY KEY,
        name TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');
  }

  Future<int> insertSeriesWatchlist(tvSeriesTable tvSeries) async {
    final db = await database;
    return await db!.insert(_tblSeriesWatchlist, tvSeries.toJson());
  }

  Future<int> removeWatchlist(tvSeriesTable tvSeries) async {
    final db = await database;
    return await db!.delete(
      _tblSeriesWatchlist,
      where: 'id = ?',
      whereArgs: [tvSeries.id],
    );
  }

  Future<Map<String, dynamic>?> getSeriesById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblSeriesWatchlist,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getSeriesWatchlist() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblSeriesWatchlist);
    return results;
  }

  
}
