import 'dart:convert';

import 'package:GADlab/unsplashPhotos/models/photo.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

class UnsplashApi {
  UnsplashApi({@required Client client})
      : assert(client != null),
        _client = client;

  final Client _client;

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

  Future<List<Photo>> getPhotos(Map<String, String> parameters) async {
    const String baseUrl = 'https://api.unsplash.com/photos/random';
    final String url = _createUrl(baseUrl, parameters);
    final Response response = await _client.get(url);
    final String body = response.body;
    final List<dynamic> list = jsonDecode(body);
    return list.map((dynamic json) => Photo.fromJson(json)).toList();
  }
}
