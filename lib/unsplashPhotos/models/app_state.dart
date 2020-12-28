library app_state;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:GADlab/unsplashPhotos/models/photo.dart';

part 'app_state.g.dart';

abstract class AppState implements Built<AppState, AppStateBuilder> {
  factory AppState([void Function(AppStateBuilder) updates]) = _$AppState;

  factory AppState.initialState() {
    final AppStateBuilder builder = AppStateBuilder();
    builder.isLoading = true;
    builder.parameters = <String, String>{
      'client_id': '88-7NL2Xec7OuLKaZvW2157SQbInDayhovteeKkkMkk',
      'count': '20',
      'query': ''
    };
    return builder.build();
  }

  AppState._();

  BuiltList<Photo> get photos;

  Map<String, String> get parameters;

  bool get isLoading;
}
