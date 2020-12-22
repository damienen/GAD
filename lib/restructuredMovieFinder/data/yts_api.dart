import 'dart:convert';

import 'package:GADlab/restructuredMovieFinder/models/movie.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

class YtsApi {
  YtsApi({@required Client client})
      : assert(client != null),
        _client = client;

  final Client _client;

  Future<List<Movie>> getMovies(Map<String, String> parameters) async {
    const String baseUrl = 'https://yts.mx/api/v2/list_movies.json';
    final String url = _createUrl(baseUrl, parameters);
    final Response response = await _client.get(url);
    final String body = response.body;
    final List<dynamic> list = jsonDecode(body)['data']['movies'];
    return list //
        .map((dynamic json) => Movie.fromJson(json))
        .toList();
  }

  String _createUrl(String baseUrl, Map<String, String> parameters) {
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
    return formedUrl;
  }
}
