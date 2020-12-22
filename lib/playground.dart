/*
import 'dart:convert';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

Future<void> main() async {
  const String url = 'https://www.worldometers.info/geography/flags-of-the-world/';
  final Response response = await get(url);
  final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
  final List<dynamic> movieList = jsonResponse['data']['movies'];
  final Movie dd=Movie.fromJson(jsonResponse['data']['movies'][2]);
  print(dd.toString());
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
}*/

import 'dart:io';

void main() {
  for (int i = 1; i <= 100; i++) {
    stdout.write('$i:');
    if (i % 3 == 0) {
      stdout.write('Fizz');
    }
    if (i % 5 == 0) {
      stdout.write('Buzz');
    }
    stdout.write('\n');
  }
}

/*Future<void> main() {
  get('https://www.worldometers.info/geography/flags-of-the-world/').then((Response response) {
    final String data = response.body;
    final List<String> items = data.split('<a href="/img/flags');
    for (final String item in items.skip(1)) {
      const String countryTitlePattern = 'padding-top:10px">';
      final String countryName =
      item.substring(item.indexOf(countryTitlePattern) + countryTitlePattern.length, item.indexOf('</div>'));
      final String flagUrl = 'https//worldometers.info/img/flags${item.split('"')[0]}';
      print(flagUrl);
    }
  });
}*/
