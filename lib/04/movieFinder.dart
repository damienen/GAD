import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

void main() {
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  List<dynamic> movieList = <dynamic>[];
  int movieNumber = 20;
  TextEditingController searchBar = TextEditingController();

  @override
  void initState() {
    _getMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Movie finder',
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Movie finder'),
            actions: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 24, top: 4, right: 4, bottom: 4),
                  child: TextField(
                    style: const TextStyle(fontSize: 20),
                    controller: searchBar,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      hintText: 'Search',
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  setState(() {});
                },
              ),
              IconButton(icon: const Icon(Icons.filter_list), onPressed: () {}),
            ],
          ),
          body: ListView(
            children: <Widget>[
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(8),
                itemCount: movieNumber,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Center(
                      child: SizedBox(
                        height: 200,
                        child: Card(
                          elevation: 4,
                          child: Row(
                            children: <Widget>[
                              if (movieList.length == movieNumber)
                                Image.network(
                                  Movie.fromJson(movieList[index]).image,
                                  fit: BoxFit.contain,
                                )
                              else
                                const Icon(Icons.file_download),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Text(
                                      movieList.length == movieNumber
                                          ? Movie.fromJson(movieList[index]).title +
                                              ' - ' +
                                              Movie.fromJson(movieList[index]).year.toString()
                                          : 'Loading',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                    ),
                                    Text(
                                      movieList.length == movieNumber
                                          ? 'Rating: ' + Movie.fromJson(movieList[index]).rating.toString()
                                          : 'Loading',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(fontSize: 16, decoration: TextDecoration.underline),
                                    ),
                                    Text(
                                      movieList.length == movieNumber
                                          ? Movie.fromJson(movieList[index]).getGenres()
                                          : 'Loading',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(fontSize: 16),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                shrinkWrap: true,
              )
            ],
          ),
        ));
  }

  Future<void> _getMovies() async {
    const String url = 'https://yts.mx/api/v2/list_movies.json';
    final Response response = await get(url);
    final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    movieList = jsonResponse['data']['movies'];
    setState(() {});
  }
}

class Movie {
  const Movie(
      {@required this.title, @required this.year, @required this.rating, @required this.image, @required this.genres});

  Movie.fromJson(dynamic item)
      : title = item['title'],
        year = item['year'],
        rating = double.parse(item['rating'].toString()),
        image = item['medium_cover_image'],
        genres = List<String>.from(item['genres']);

  final String title;
  final int year;
  final double rating;
  final String image;
  final List<String> genres;

  @override
  String toString() {
    return 'Movie{title: $title, year: $year, rating: $rating, genres: $genres}';
  }

  String getGenres() {
    String formattedGenres = '';
    for (int i = 0; i < genres.length; i++) {
      formattedGenres += genres[i];
      if (i != genres.length - 1) {
        formattedGenres += ', ';
      }
    }
    return formattedGenres;
  }
}
