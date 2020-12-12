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
  String movieUrl = 'https://yts.mx/api/v2/list_movies.json';
  Map<String, String> parameters = <String, String>{'order_by': 'desc', 'quality': 'All', 'page': '1'};
  List<dynamic> movieList = <dynamic>[];
  int movieNumber = 20;
  TextEditingController searchBar = TextEditingController();
  bool orderDescending = true;
  bool hqOn = false;

  @override
  void initState() {
    _getMovies(movieUrl);
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
                  padding: const EdgeInsets.only(left: 24, top: 4, right: 24, bottom: 4),
                  child: TextField(
                    style: const TextStyle(fontSize: 20),
                    controller: searchBar,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      suffixIcon: IconButton(
                        icon: const Icon(
                          Icons.clear,
                          color: Colors.white,
                        ),
                        onPressed: () => searchBar.clear(),
                      ),
                    ),
                    onSubmitted: (String value) {
                      setState(() {
                        if (searchBar.text.isNotEmpty) {
                          parameters.update('query_term', (String value) => value, ifAbsent: () {
                            return value;
                          });
                        } else {
                          parameters.remove('query_term');
                        }
                      });
                    },
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  parameters.update('page', (String value) => 1.toString());
                  setState(() {
                    if (searchBar.text.isNotEmpty) {
                      parameters.update('query_term', (String value) => searchBar.text, ifAbsent: () {
                        return searchBar.text;
                      });
                    } else {
                      parameters.remove('query_term');
                    }

                    _getMovies(createUrl(movieUrl, parameters), reset: true);
                  });
                },
              ),
              IconButton(
                icon: hqOn ? const Icon(Icons.high_quality_outlined) : const Icon(Icons.high_quality),
                onPressed: () {
                  hqOn = !hqOn;
                  parameters.update('quality', (String value) => hqOn ? '2160p' : 'All');
                  parameters.update('page', (String value) => 1.toString());
                  _getMovies(createUrl(movieUrl, parameters), reset: true);
                  setState(() {});
                },
              ),
              IconButton(
                  icon: orderDescending ? const Icon(Icons.arrow_downward) : const Icon(Icons.arrow_upward),
                  onPressed: () {
                    orderDescending = !orderDescending;
                    parameters.update('order_by', (String value) => orderDescending ? 'desc' : 'asc');
                    parameters.update('page', (String value) => 1.toString());
                    _getMovies(createUrl(movieUrl, parameters), reset: true);
                    setState(() {});
                  }),
            ],
          ),
          body: ListView(
            children: <Widget>[
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(8),
                itemCount: movieNumber + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index == movieNumber) {
                    return Container(
                      color: Colors.greenAccent,
                      child: FlatButton(
                        child: const Text('Load More'),
                        onPressed: () {
                          parameters.update('page', (String value) => (int.parse(parameters['page']) + 1).toString());
                          _getMovies(createUrl(movieUrl, parameters), reset: false);
                          setState(() {});
                        },
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
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
                    );
                  }
                },
                shrinkWrap: true,
              )
            ],
          ),
        ));
  }

  Future<void> _getMovies(String url, {bool reset = true}) async {
    final Response response = await get(url);
    final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    if (reset) {
      movieList = jsonResponse['data']['movies'];
    } else {
      if (jsonResponse['data']['movies'] != null) {
        movieList.addAll(jsonResponse['data']['movies']);
      }
    }
    setState(() {
      if (movieList != null)
        movieNumber = movieList.length;
      else
        movieNumber = 0;
    });
  }

  String createUrl(String baseUrl, Map<String, String> parameters) {
    String formedUrl = baseUrl;
    if (parameters.isEmpty)
      return baseUrl;
    else {
      formedUrl += '?';
      formedUrl += parameters.keys.elementAt(0) + '=' + parameters.values.elementAt(0);
      for (int i = 1; i < parameters.length; i++) {
        formedUrl += '&' + parameters.keys.elementAt(i) + '=' + parameters.values.elementAt(i);
      }
    }
    print(formedUrl);
    return formedUrl;
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
