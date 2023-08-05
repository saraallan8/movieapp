
class Movie {
  final String type;
  final String poster; 
  final String title; 
  final String year;
  final String mov_id;
  final String IMDB_rating;
  final String Genre ;
  final String Writer;
  final String Director;
  final String Actors;
  final String plot;
  bool AddToFav=false;

  Movie({this.type, this.title, this.poster, this.year,this.mov_id,this.IMDB_rating,this.Actors,this.Director,this.Genre,this.plot,this.Writer});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      type: json["Type"] ,
      poster: json["Poster"], 
      title: json["Title"], 
      year: json["Year"],
      mov_id: json["imdbID"],
      IMDB_rating:json["Rated"],
      Genre: json["Genre"],
      Writer: json["Writer"],
      Director: json["Director"],
      Actors: json["Actors"],
      plot: json["Plot"],
    );
  }
  @override
  String toString() {
    // TODO: implement toString
    return (title + year + IMDB_rating + Genre).toLowerCase();
  }
}
