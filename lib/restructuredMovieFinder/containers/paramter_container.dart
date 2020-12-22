import 'package:GADlab/restructuredMovieFinder/models/app_state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class ParameterContainer extends StatelessWidget {
  const ParameterContainer({Key key, @required this.builder}) : super(key: key);

  final ViewModelBuilder<Map<String, String>> builder;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Map<String, String>>(
      converter: (Store<AppState> store) {
        return store.state.parameters;
      },
      builder: builder,
    );
  }
}
