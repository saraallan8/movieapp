

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ssa_movies/models/movie.dart';
import 'package:ssa_movies/models/watchlist_model.dart';
import 'package:ssa_movies/widgets/detailsPage.dart';
import 'package:ssa_movies/widgets/watchllist_page.dart';

class MoviesWidget extends StatelessWidget {

  Future <List<Movie>> movies;

  MoviesWidget({this.movies});

  @override
  Widget build(BuildContext context) {

    var Wl=Provider.of<WatchList>(context);
    return FutureBuilder <List<Movie>> (
      future: movies,
      builder:(context,snapshot) {

        if (snapshot.hasData) {
          List <Movie>m = snapshot.data ?? [];
          return ListView.builder(


                itemCount: (snapshot.data.length),

                itemBuilder: (context, index) {
                  final movie =snapshot.data[index];
                  return GestureDetector(
                    onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>MovieDetails(snapshot.data[index].mov_id)));

                  },
                    child: Card(

                      child: Container(

                          child: Row(children: [
                            SizedBox(
                                width: 100,
                                child: ClipRRect(
                                  child: Image.network(movie.poster,fit:BoxFit.cover,
                                  errorBuilder: (context,error,stackTrace){
                                    return Container(
                                      child: Image.asset("assets/images/pic.jpg"),
                                            //  fit: BoxFit.,
                                     // child: Icon(Icons.ten_mp),
                                    );
                                  }),
                                  borderRadius: BorderRadius.circular(10),

                                ),


                            ),
                            SizedBox(
                              width: 150,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Title :" + movie.title),
                                    Divider(
                                      endIndent: 3,
                                      thickness: 5,
                                      color: Colors.redAccent,
                                    ),

                                    Text("Year :" + movie.year),
                                    Text("Type :" + movie.type),

                                  ],),
                              ),
                            ), Expanded(child: Container()),
                             Consumer<WatchList>(
                          builder: (context, FavList,child){

                            return IconButton(
                              icon: movie.AddToFav
                                  ? Icon(Icons.favorite,color: Colors.red,)
                                  : Icon(Icons.favorite_border,),

                              onPressed: () {
                                movie.AddToFav=!movie.AddToFav;
                              if(movie.AddToFav)
                              {
                                Wl.AddToList(movie);
                              
                              }else{
                                Wl.DeleteFromList(movie);
                             
                              }


                                print (movie.AddToFav);

                                //Navigator.push(context, MaterialPageRoute(builder: (context)=>WatchList_Page()));
                              },);
                          },
                        )

                          ],
                          
                          ),
                          


                        
                                              /* Builder(
                          builder: (context) {
                            return IconButton(

                              icon: movie.AddToFav
                                  ? Icon(Icons.favorite,color: Colors.red,)
                                  : Icon(Icons.favorite_border,),
                               onPressed: () {
                                movie.AddToFav=!movie.AddToFav;

                              //Navigator.push(context, MaterialPageRoute(builder: (context)=>WatchList_Page()));
                            },);
                          }
                        ),*/
                      ),

                    ),
                  );

                }
            );



        }
        else if(snapshot.hasError){
          return Container(
            decoration:  new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage("assets/images/pic.jpg"),
                  //  fit: BoxFit.,
                )
            ),
          );
        }

          return  Container(
              child:Center(
                child:  CircularProgressIndicator(
                  backgroundColor: Colors.cyanAccent,
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
                ),
              )
          );

      }
    );


    
  }

}