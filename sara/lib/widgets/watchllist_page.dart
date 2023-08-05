
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ssa_movies/models/watchlist_model.dart';
import 'package:ssa_movies/models/movie.dart';
import 'package:ssa_movies/widgets/detailsPage.dart';
import '../main.dart';

class WatchList_Page extends StatefulWidget {
  String genre;
  WatchList_Page(this.genre);
  @override
  _WatchList_PageState createState() => _WatchList_PageState();
}

class _WatchList_PageState extends State<WatchList_Page> {
  TextEditingController searchContraller = TextEditingController();
  List<Movie> FilteredMovie = [];

  @override
  void initstate() {
    super.initState();
     
  }

  bool isListOpen = false;
  Widget build(BuildContext context) {
   
    print(widget.genre);
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
                    ),
              ),
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
                  //         builder: (context) => WatchList_Page()));
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
                            
                  Provider.of<WatchList>(context,listen: false).Items('All');
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
                            
                  Provider.of<WatchList>(context,listen: false).Items('Action');
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
                            
                  Provider.of<WatchList>(context,listen: false).Items('Drama');
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
                            
                  Provider.of<WatchList>(context,listen: false).Items('Crime');
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
                            
                  Provider.of<WatchList>(context,listen: false).Items('Adventure');
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
                            
                  Provider.of<WatchList>(context,listen: false).Items('Comedy');
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
          "My Watch List",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextFormField(
                keyboardType: TextInputType.text,
                controller: searchContraller,
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
                      onPressed: () {
                        Provider.of<WatchList>(context, listen: false)
                            .searchInWatchList(searchContraller.text);
                      },
                      icon: Icon(Icons.search)),
                )),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Consumer<WatchList>(
                  builder: (context, FavList, child) {
                    return ListView.builder(
                      itemCount: FavList.tempList.length,
                      itemBuilder: (context, index) {
                        final movie = FavList.tempList[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MovieDetails(
                                    FavList.tempList[index].mov_id),
                              ),
                            );
                          },
                          child: Dismissible(
                            key: Key(FavList.tempList[index].title),
                            onDismissed: (direction) {
                              FavList.DeleteFromList(FavList.tempList[index]);
                            },
                            child: ListTile(
                              title: Row(
                                children: [
                                  SizedBox(
                                      height: 100,
                                      width: 100,
                                      child: Image.network(
                                          FavList.FavList[index].poster,
                                          fit: BoxFit.cover, errorBuilder:
                                              (context, error, stackTrace) {
                                        return Container(
                                          color: Colors.black12,
                                          child: Icon(Icons.movie),
                                        );
                                      })),
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Name: ' +
                                                FavList.tempList[index].title,
                                          ),
                                          Text(
                                            'ID: ' +
                                                FavList.tempList[index].mov_id,
                                          ),
                                          Text(
                                            'Year: ' +
                                                FavList.tempList[index].year,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
