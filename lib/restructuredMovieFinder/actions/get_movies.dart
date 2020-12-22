import 'package:GADlab/restructuredMovieFinder/models/movie.dart';

class GetMovies {
  GetMovies(this.parameters);

  Map<String, String> parameters;
}

class GetMoviesSuccessful {
  GetMoviesSuccessful(this.movies);

  final List<Movie> movies;
}

class GetMoviesError {
  const GetMoviesError(this.error);

  final dynamic error;
}
