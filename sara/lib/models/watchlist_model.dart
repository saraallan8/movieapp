import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:http/http.dart' as http;
import 'package:ssa_movies/models/movie.dart';
import 'package:path/path.dart';

class WatchList extends ChangeNotifier {
  int _count = 0;
  List<Movie> FavList = [];

  List<Movie> tempList = [];

  Database _database;

  Future<void> fetchMovies() async {
    try {
      List<Map> list = await _database.rawQuery('SELECT * FROM movies');
      FavList.clear();

      for (int i = 0; i < list.length; i++) {
        FavList.add(Movie.fromJson(list[i]));
      }
      notifyListeners();
    } catch (e) {
      e.toString();
    }
  }

  void searchInWatchList(String text) {
    text = text.toLowerCase();
    tempList.clear();
    for (int i = 0; i < FavList.length; i++) {
      if (FavList[i].toString().contains(text)) {
        tempList.add(FavList[i]);
      }
    }

    notifyListeners();
  }

  Future<void> creatDataBase() async {
    _database = await openDatabase(
      join(
        await getDatabasesPath(),
        'database.db',
      ),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE movies(imdbID TEXT  PRIMARY KEY,Poster TEXT ,Year TEXT ,Title TEXT,Type TEXT ,Actors TEXT ,Rated TEXT ,Writer TEXT,Director TEXT,Plot TEXT ,Genre TEXT )',
        );
      },
      version: 1,
    );
    await fetchMovies();
  }

  int get count {
    return FavList.length;
  }

  AddToList(Movie movie) async {
    try {
      var url = "https://www.omdbapi.com/?i=${movie.mov_id}&apikey=7a9bf256";
      final response = await http.get(url);
      if (response.statusCode == 200) {
        movie = Movie.fromJson(jsonDecode(response.body));

        await _database.insert(
          'movies', //table name
          {
            'imdbID': movie.mov_id,
            'Poster': movie.poster,
            'Title': movie.title,
            'Year': movie.year,
            'Type': movie.type,
            'Actors': movie.Actors,
            'Writer': movie.Writer,
            'Director': movie.Director,
            'Plot': movie.plot,
            'Genre': movie.Genre,
            'Rated': movie.IMDB_rating,
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );

        FavList.add(movie);

        notifyListeners();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  DeleteFromList(Movie movie) async {
    try {
      await _database.delete(
        'movies',
        where: 'imdbID = ?',
        whereArgs: [movie.mov_id],
      );
      FavList.remove(movie);
      tempList.remove(movie);
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  void Items(String genre) {
    print('object');
    tempList.clear();
    if (genre == 'All') {
      tempList = List.from(FavList);
    } else {
      for (int i = 0; i < FavList.length; i++) {
        if (FavList[i].Genre.contains(genre)) {
          tempList.add(FavList[i]);
        }
      }
    }

    notifyListeners();
  }
}
