import 'package:GADlab/unsplashPhotos/actions/change_parameter.dart';
import 'package:GADlab/unsplashPhotos/actions/get_photos.dart';
import 'package:GADlab/unsplashPhotos/data/unsplash_api.dart';
import 'package:GADlab/unsplashPhotos/models/app_state.dart';
import 'package:GADlab/unsplashPhotos/models/photo.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class AppMiddleware {
  const AppMiddleware({@required UnsplashApi unsplashApi})
      : assert(unsplashApi != null),
        _unsplashApi = unsplashApi;

  final UnsplashApi _unsplashApi;

  List<Middleware<AppState>> get middleware {
    return <Middleware<AppState>>[_getPhotos, _changeParameter];
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

  Future<void> _getPhotos(Store<AppState> store, dynamic action, NextDispatcher next) async {
    next(action);
    if (action is GetPhotos) {
      try {
        print(action.parameters);
        final List<Photo> photos = await _unsplashApi.getPhotos(action.parameters);

        final GetPhotosSuccessful successful = GetPhotosSuccessful(photos);
        store.dispatch(successful);
      } catch (e) {
        final GetPhotosError error = GetPhotosError(e);
        store.dispatch(error);
      }
    }
  }
}
