import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ssa_movies/models/movie.dart';
import 'package:ssa_movies/widgets/moviesdisplay.dart';
import 'package:http/http.dart' as http;
import 'package:ssa_movies/models/watchlist_model.dart';
import 'dart:async';
import 'package:provider/provider.dart';

import 'package:ssa_movies/widgets/watchllist_page.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => WatchList(), child: SSA_App()));
}

//class Search_Controller extends
class SSA_App extends StatefulWidget {
  @override
  _SSA_App createState() => _SSA_App();
}

class _SSA_App extends State<SSA_App> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<WatchList>(context, listen: false).creatDataBase();
  }

  @override
  Widget build(BuildContext context) {
    var Wl = Provider.of<WatchList>(context);

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Movies Application",
        home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController SSAcontroller = TextEditingController();
  Future<List<Movie>> _movies;

  @override
  void initState() {
    super.initState();

    _AddAllMovies();
  }

  void _AddAllMovies() {
    final movies = _fetch_Movies(SSAcontroller.text);
    setState(() {
      _movies = movies;
    });
  }

  Future<List<Movie>> _fetch_Movies(String str) async {
    try {
      final response =
          await http.get("https://www.omdbapi.com/?s=${str}&apikey=877f5c83");

      if (response.statusCode == 200) {
        
        final result = jsonDecode(response.body);
         if (result["Response"] == "False") {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text('invalid name!'),
            duration: const Duration(seconds: 1),
          ));
        }
        Iterable list = result["Search"];
        return list.map((movie) => Movie.fromJson(movie)).toList();
      }
    } catch (e) {
      throw Exception("Failed to load movies!");
    }
  }

  bool isListOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Builder(builder: (context) {
        return Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                  ),
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.duo_rounded,
                        color: Colors.black12,
                        size: 60,
                      ),
                      Text(
                        " Movie Site",
                        style: TextStyle(
                            color: Colors.black12,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ) // Text('',style: TextStyle(fontSize:20,),) ,
                      )),
              ListTile(
                leading: const Icon(Icons.home),
                title: Text('Home Movies '),
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.favorite),
                title: Text('Favourite Movies '),
                trailing: Text(
                  Provider.of<WatchList>(context, listen: false)
                      .count
                      .toString(),
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () {
                  // Navigator.pushReplacement(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => WatchList_Page('')));
                  setState(() {
                    isListOpen = !isListOpen;
                  });
                },
              ),
              isListOpen
                  ? Column(
                      children: [
                        ListTile(
                          title: Text('                           All'),
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        WatchList_Page('All')));
                          },
                        ),
                        ListTile(
                          title: Text('                           Action'),
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        WatchList_Page('Action')));
                          },
                        ),
                        ListTile(
                          title: Text('                           Drama'),
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        WatchList_Page('Drama')));
                          },
                        ),
                        ListTile(
                          title: Text('                           Crime'),
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        WatchList_Page('Crime')));
                          },
                        ),
                        ListTile(
                          title: Text('                           Adventure'),
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        WatchList_Page('Adventure')));
                          },
                        ),
                        ListTile(
                          title: Text('                           Comedy'),
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        WatchList_Page('Comedy')));
                          },
                        ),
                      ],
                    )
                  : Container(),
              ListTile(
                title: Text('Setting'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                title: Text('Sign Out'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
            ],
          ),
        );
      }),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        title: Text(
          "  Movies ",
          style: TextStyle(color: Colors.black, fontSize: 25.0),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextFormField(
                keyboardType: TextInputType.text,
                controller: SSAcontroller,
                decoration: InputDecoration(
                  labelText: "search...",
                  prefixIcon: Icon(
                    Icons.movie,
                    color: Colors.black12,
                    size: 20,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: BorderSide(
                      color: Colors.black87,
                    ),
                  ),
                  filled: true,
                  hoverColor: Colors.black12,
                  contentPadding: EdgeInsets.all(20.0),
                  // hintText:  "Search... ",
                  // hintStyle: TextStyle(color:Colors.black87,fontSize: 20),

                  suffixIcon: IconButton(
                      splashColor: Colors.black87,
                      color: Colors.redAccent,
                      onPressed: () => {_AddAllMovies(), SSAcontroller.clear()},
                      icon: Icon(Icons.search)),
                )),
            Expanded(
                child: Container(
              padding: EdgeInsets.all(10.0),
              child: MoviesWidget(movies: _movies),
            ))
          ],
        ),
      ),
    );
  }
}
