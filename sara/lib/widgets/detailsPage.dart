import 'dart:ui';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ssa_movies/models/movie.dart';
//import 'package:ssa_movies/widgets/moviesdisplay.dart';


class MovieDetails extends StatefulWidget {
     final String Str;

  MovieDetails(this.Str);

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  Future<Movie> movieInfo;

  void initState() {
    super.initState();
    _AddAllDetails();
  }

  void _AddAllDetails() {

   final movie= _fetch_Details(widget.Str);
    setState(() {
      movieInfo = movie;
      print(movieInfo);

    });
 }

  Future<Movie> _fetch_Details(String str) async {

    var URL="https://www.omdbapi.com/?i=${str}&apikey=877f5c83";
    try {
      final response = await http.get(URL);

      if (response.statusCode == 200) //if OK (successful Response)
      {
       return Movie.fromJson(jsonDecode(response.body));
      }
      //else  return CircularProgressIndicator();

    }catch(e) {

      throw Exception("Failed to load  the details movies!");
    }

  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Movie>(
         future: movieInfo ,
        builder: (context,snapshot){

           if (snapshot.hasData) {
        Movie m = snapshot.data ?? " no result";
        return Scaffold(
          appBar: AppBar(title: Text("About This Movie",style: TextStyle(color: Colors.black,fontSize: 20.0),),centerTitle: true,backgroundColor: Colors.redAccent,),
          body: Container(
            alignment: Alignment.center,
            color:Colors.white38,
            child: Column(
              children: [
                SizedBox(
                  height:200 ,
                  width:200,
                  child: ClipRRect(
                    child: Image.network(m.poster,fit:BoxFit.fill,
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

            Expanded(child: ListView(

              children: [
                Row(
                  children: [
                    Icon(Icons.duo_rounded) ,

                    Flexible(child: Padding(
                      padding: EdgeInsets.all(0.8),
                      child: Text("Title :"+m.title,style: TextStyle(fontSize: 20,color: Colors.black87,),textAlign:TextAlign.justify,),
                    )),],), // Title
              Divider(),
              Row(
                children: [
                  Icon(Icons.movie),

                  Text("    Movie Type  :"+m.type,style: TextStyle(fontSize: 20,color: Colors.black87),textAlign:TextAlign.center,),],),// Type
              Divider(),

              Row(children: [
                Icon(Icons.event  ),

                Text("     Year of Production:"+m.year,style: TextStyle(fontSize: 20,color: Colors.black87,),textAlign:TextAlign.center,),
              ],),//year
              Divider(),
              Row(children: [
                Icon(Icons.list ),

                Text("     Movie ID:"+m.mov_id,style: TextStyle(fontSize: 20,color: Colors.black87,),textAlign:TextAlign.center,),
              ],),//Id
                Divider(),
                Row(
                  children: [
                    Icon(Icons.duo_rounded) ,

                    Flexible(child: Padding(
                      padding: EdgeInsets.all(0.8),
                      child: Text("Writer :"+m.Writer,style: TextStyle(fontSize: 20,color: Colors.black87,),textAlign:TextAlign.justify,),
                    )),],), //writer
               Divider(),
                Row(
                  children: [
                    Icon(Icons.duo_rounded , ),

                    Text("     Genre :"+m.Genre,style: TextStyle(fontSize: 20,color: Colors.black87,),textAlign:TextAlign.center,),],),//Genre
                Divider(),
                Row(
                  children:[
                  Icon(Icons.duo_rounded) ,

                    Flexible(child: Padding(
                    padding: EdgeInsets.all(0.8),
                    child: Text("Plot :"+m.plot,style: TextStyle(fontSize: 20,color: Colors.black87,),textAlign:TextAlign.justify,overflow: TextOverflow.fade,),
                           ))
                  ],) ,//plot
                Divider(),
                Row(
                  children: [
                    Icon(Icons.list, ),

                    Text("     Rating :"+m.IMDB_rating,style: TextStyle(fontSize: 20,color: Colors.black87,),textAlign:TextAlign.center,),],), //Rating
                Divider(),
                Row(
                  children: [
                    Icon(Icons.duo_rounded , ),

                    Text("     Director :"+m.Director,style: TextStyle(fontSize: 20,color: Colors.black87,),textAlign:TextAlign.center,),],), //Director
                Divider(),
                Row(
                  children: [
                    Icon(Icons.duo_rounded) ,

                    Flexible(child: Padding(
                      padding: EdgeInsets.all(0.8),
                      child: Text("Actors:"+m.Actors,style: TextStyle(fontSize: 20,color: Colors.black87,),textAlign:TextAlign.justify,),
                    ))
                  ],), //Actors

                     ],


            ),
          )
            ]
        ),
          )
        );

      }else return Container(
               child:Center(
                 child:  CircularProgressIndicator(
                 backgroundColor: Colors.cyanAccent,
                 valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
           ),
          )
           );
         }
      );

    /*ListTile(

      title: Row(
        children: [
          Flexible(child: Padding(
            padding: EdgeInsets.all(0.8),
            child: Text("     Plot :"+m.plot,/*style: TextStyle(fontSize: 20,color: Colors.black87,),textAlign:TextAlign.justify,maxLines:4,overflow: TextOverflow.ellipsis,*/),
          ))

          //Icon(Icons.duo_rounded , ),

          ,],

      ),)*/


  /*  child:Center(
      child:  CircularProgressIndicator(
        backgroundColor: Colors.cyanAccent,
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
      ),
    )*/



     /*Scaffold(
      appBar: AppBar(title: Text("About This Movie",style: TextStyle(color: Colors.black,fontSize: 20.0),),centerTitle: true,backgroundColor: Colors.redAccent,),
      body:
        Container(



          child: Column(
            children: [

              Container(
                alignment: Alignment.center,
               padding: EdgeInsets.all(1000),
                width:400,
                height: 350,
                decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(movieInfo.poster), fit: BoxFit.fill),
              ),),
              Expanded(child: ListView(

                children: [
                  Row(
            +      children: [
                    Icon(Icons.duo_rounded , ),

                    Text("     Title :"+movieInfo.title,style: TextStyle(fontSize: 20,color: Colors.black87,),textAlign:TextAlign.center,),],),
                  Divider(),
                  Row(
                    children: [
                    Icon(Icons.movie),

                    Text("    Movie Type  :"+movieInfo.Type,style: TextStyle(fontSize: 20,color: Colors.black87),textAlign:TextAlign.center,),],),
                    Divider(),

                    Row(children: [
                    Icon(Icons.event  ),

                    Text("     Year of Production:"+movieInfo.year,style: TextStyle(fontSize: 20,color: Colors.black87,),textAlign:TextAlign.center,),
                    ],),
                  Divider(),
                  Row(children: [
                    Icon(Icons.list ),

                    Text("     Movie ID:"+movieInfo.mov_id,style: TextStyle(fontSize: 20,color: Colors.black87,),textAlign:TextAlign.center,),
                  ],),

                ],
                 )


              )
           ],
         ),


        ),);*/




  }
}
