import 'package:GADlab/unsplashPhotos/actions/change_parameter.dart';
import 'package:GADlab/unsplashPhotos/actions/get_photos.dart';
import 'package:GADlab/unsplashPhotos/models/app_state.dart';

AppState reducer(AppState state, dynamic action) {
  print('action: $action');
  final AppStateBuilder builder = state.toBuilder();

  if (action is GetPhotos) {
    builder.isLoading = true;
  } else if (action is GetPhotosSuccessful) {
    builder.isLoading = false;
    builder.photos.clear();
    builder.photos.addAll(action.photos);
  } else if (action is GetPhotosError) {
    builder.isLoading = false;
  } else if (action is ChangeParameter) {
    builder.parameters.update(action.parameter, (String value) => action.value, ifAbsent: () {
      return null;
    });
  } else if (action is ChangeParameterSuccessful) {
  } else if (action is ChangeParameterError) {}

  return builder.build();
}
