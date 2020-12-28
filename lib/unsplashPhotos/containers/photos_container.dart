import 'package:GADlab/unsplashPhotos/models/photo.dart';
import 'package:GADlab/unsplashPhotos/models/app_state.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class PhotosContainer extends StatelessWidget {
  const PhotosContainer({Key key, @required this.builder}) : super(key: key);

  final ViewModelBuilder<BuiltList<Photo>> builder;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, BuiltList<Photo>>(
      converter: (Store<AppState> store) {
        return store.state.photos;
      },
      builder: builder,
    );
  }
}
