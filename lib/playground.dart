import 'dart:convert';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

Future<void> main() async {
  const String url = 'https://yts.mx/api/v2/list_movies.json';
  final Response response = await get(url);
  final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
  final List<dynamic> movieList = jsonResponse['data']['movies'];

  //print(result.toString());
}

class Movie {
  const Movie({@required this.title, @required this.year, @required this.summary, @required this.genres});

  Movie.fromJson(dynamic item)
      : title = item['title'],
        year = item['year'],
        summary = item['summary'],
        genres = List<String>.from(item['genres']);

  final String title;
  final int year;
  final String summary;
  final List<String> genres;

  @override
  String toString() {
    return 'Movie{title: $title, year: $year, summary: $summary, genres: $genres}';
  }
}

/*
void main() async {
  const url='https://yts.mx/api/v2/list_movies.json';
  get(url).then((Response response){
    Map<String, dynamic> map = jsonDecode(response.body);
    print(map['status']);
  });

}
*/
/*for (int i = 0; i < movieList.length; i++) {
    print(movieList[i]['title']);
  }*/
