import 'package:GADlab/restructuredMovieFinder/actions/change_parameter.dart';
import 'package:GADlab/restructuredMovieFinder/actions/get_movies.dart';
import 'package:GADlab/restructuredMovieFinder/data/yts_api.dart';
import 'package:GADlab/restructuredMovieFinder/models/app_state.dart';
import 'package:GADlab/restructuredMovieFinder/models/movie.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class AppMiddleware {
  const AppMiddleware({@required YtsApi ytsApi})
      : assert(ytsApi != null),
        _ytsApi = ytsApi;

  final YtsApi _ytsApi;

  List<Middleware<AppState>> get middleware {
    return <Middleware<AppState>>[_getMovies, _changeParameter];
  }

  void _changeParameter(Store<AppState> store, dynamic action, NextDispatcher next) {
    next(action);
    if (action is ChangeParameter) {
      try {
        final ChangeParameterSuccessful successful = ChangeParameterSuccessful(store.state.parameters);
        store.dispatch(successful);
      } catch (e) {
        final ChangeParameterError error = ChangeParameterError(e);
        store.dispatch(error);
      }
    }
  }

  Future<void> _getMovies(Store<AppState> store, dynamic action, NextDispatcher next) async {
    next(action);
    if (action is GetMovies) {
      try {
        print(action.parameters);
        final List<Movie> movies = await _ytsApi.getMovies(action.parameters);

        final GetMoviesSuccessful successful = GetMoviesSuccessful(movies);
        store.dispatch(successful);
      } catch (e) {
        final GetMoviesError error = GetMoviesError(e);
        store.dispatch(error);
      }
    }
  }
}
