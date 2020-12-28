import 'package:GADlab/unsplashPhotos/actions/change_parameter.dart';
import 'package:GADlab/unsplashPhotos/actions/get_photos.dart';
import 'package:GADlab/unsplashPhotos/containers/is_loading_container.dart';
import 'package:GADlab/unsplashPhotos/containers/photos_container.dart';
import 'package:GADlab/unsplashPhotos/containers/parameter_container.dart';
import 'package:GADlab/unsplashPhotos/models/app_state.dart';
import 'package:GADlab/unsplashPhotos/models/photo.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);
  final TextEditingController searchBar = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ParameterContainer(builder: (BuildContext context, Map<String, String> parameters) {
      return IsLoadingContainer(
        builder: (BuildContext context, bool isLoading) {
          return Scaffold(
            appBar: AppBar(
              actions: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 24, top: 4, right: 24, bottom: 4),
                    child: TextField(
                      style: const TextStyle(fontSize: 20),
                      controller: searchBar,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'Search',
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.clear,
                            color: Colors.white,
                          ),
                          onPressed: () => searchBar.clear(),
                        ),
                      ),
                      onSubmitted: (String value) {
                        if (searchBar.text.isNotEmpty) {
                          StoreProvider.of<AppState>(context).dispatch(ChangeParameter('query', searchBar.text));
                        } else {
                          StoreProvider.of<AppState>(context).dispatch(ChangeParameter('query', ''));
                        }
                      },
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    if (searchBar.text.isNotEmpty) {
                      StoreProvider.of<AppState>(context).dispatch(ChangeParameter('query', searchBar.text));
                    } else {
                      StoreProvider.of<AppState>(context).dispatch(ChangeParameter('query', ''));
                    }
                    StoreProvider.of<AppState>(context)
                        .dispatch(GetPhotos(StoreProvider.of<AppState>(context).state.parameters));
                  },
                ),
              ],
            ),
            body: Builder(
              builder: (BuildContext context) {
                if (isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return PhotosContainer(builder: (BuildContext context, BuiltList<Photo> photos) {
                  return ListView(
                    children: <Widget>[
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(8),
                        itemCount: photos.length + 1,
                        itemBuilder: (BuildContext context, int index) {
                          if (index == photos.length) {
                            return Container(
                              color: Colors.greenAccent,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  FlatButton(
                                    child: const Text('Regenerate photos'),
                                    onPressed: () {
                                      StoreProvider.of<AppState>(context)
                                          .dispatch(GetPhotos(StoreProvider.of<AppState>(context).state.parameters));
                                    },
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Card(
                                elevation: 2,
                                child: Image.network(
                                  photos[index].urls['small'],
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            );
                          }
                        },
                        shrinkWrap: true,
                      )
                    ],
                  );
                });
              },
            ),
          );
        },
      );
    });
  }
}
