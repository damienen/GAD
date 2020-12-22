import 'package:GADlab/restructuredMovieFinder/actions/change_parameter.dart';
import 'package:GADlab/restructuredMovieFinder/actions/get_movies.dart';
import 'package:GADlab/restructuredMovieFinder/models/app_state.dart';

AppState reducer(AppState state, dynamic action) {
  print('action: $action');
  final AppStateBuilder builder = state.toBuilder();

  if (action is GetMovies) {
    builder.isLoading = true;
  } else if (action is GetMoviesSuccessful) {
    builder.isLoading = false;
    builder.movies.clear();
    builder.movies.addAll(action.movies);
  } else if (action is GetMoviesError) {
    builder.isLoading = false;
  } else if (action is ChangeParameter) {
    builder.parameters.update(action.parameter, (String value) => action.value, ifAbsent: () {
      return null;
    });
  } else if (action is ChangeParameterSuccessful) {
  } else if (action is ChangeParameterError) {}

  return builder.build();
}
