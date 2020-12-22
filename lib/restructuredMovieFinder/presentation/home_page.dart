import 'package:GADlab/restructuredMovieFinder/actions/change_parameter.dart';
import 'package:GADlab/restructuredMovieFinder/actions/get_movies.dart';
import 'package:GADlab/restructuredMovieFinder/containers/is_loading_container.dart';
import 'package:GADlab/restructuredMovieFinder/containers/movies_container.dart';
import 'package:GADlab/restructuredMovieFinder/containers/paramter_container.dart';
import 'package:GADlab/restructuredMovieFinder/models/app_state.dart';
import 'package:GADlab/restructuredMovieFinder/models/movie.dart';
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
                          StoreProvider.of<AppState>(context).dispatch(ChangeParameter('query_term', searchBar.text));
                        } else {
                          StoreProvider.of<AppState>(context).dispatch(ChangeParameter('query_term', ''));
                        }
                      },
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    StoreProvider.of<AppState>(context).dispatch(ChangeParameter('page', '1'));
                    if (searchBar.text.isNotEmpty) {
                      StoreProvider.of<AppState>(context).dispatch(ChangeParameter('query_term', searchBar.text));
                    } else {
                      StoreProvider.of<AppState>(context).dispatch(ChangeParameter('query_term', ''));
                    }
                    StoreProvider.of<AppState>(context)
                        .dispatch(GetMovies(StoreProvider.of<AppState>(context).state.parameters));
                  },
                ),
                /*IconButton(
                  icon: parameters['quality'] == '2160p'
                      ? const Icon(Icons.high_quality_outlined)
                      : const Icon(Icons.high_quality),
                  onPressed: () {
                    //TODO negate the High Quality attribute/update parameter to change high quality
                    //TODO change page to 1
                    //TODO get movies action
                  },
                ),
                IconButton(
                    icon: parameters['order_by'] == 'desc'
                        ? const Icon(Icons.arrow_downward)
                        : const Icon(Icons.arrow_upward),
                    onPressed: () {
                      //TODO negate the order by attribute/update parameter to change order by
                      //TODO change page to 1
                      //TODO get movies action
                    }),*/
              ],
            ),
            body: Builder(
              builder: (BuildContext context) {
                if (isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return MoviesContainer(builder: (BuildContext context, BuiltList<Movie> movies) {
                  return ListView(
                    children: <Widget>[
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(8),
                        itemCount: movies.length + 1,
                        itemBuilder: (BuildContext context, int index) {
                          if (index == movies.length) {
                            return Container(
                              color: Colors.greenAccent,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  /*
                                  RaisedButton(
                                    child: const Text('Previous page'),
                                    onPressed: () {
                                      StoreProvider.of<AppState>(context).dispatch(ChangeParameter(
                                          'page',
                                          (int.parse(StoreProvider.of<AppState>(context).state.parameters['page']) - 1)
                                              .toString()));
                                      StoreProvider.of<AppState>(context)
                                          .dispatch(GetMovies(StoreProvider.of<AppState>(context).state.parameters));
                                    },
                                  ),*/
                                  RaisedButton(
                                    child: const Text('Next page'),
                                    onPressed: () {
                                      StoreProvider.of<AppState>(context).dispatch(ChangeParameter(
                                          'page',
                                          (int.parse(StoreProvider.of<AppState>(context).state.parameters['page']) + 1)
                                              .toString()));
                                      StoreProvider.of<AppState>(context)
                                          .dispatch(GetMovies(StoreProvider.of<AppState>(context).state.parameters));
                                    },
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: SizedBox(
                                height: 200,
                                child: Card(
                                  elevation: 4,
                                  child: Row(
                                    children: <Widget>[
                                      Image.network(
                                        movies[index].mediumCoverImage,
                                        fit: BoxFit.contain,
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Text(
                                              movies[index].title + ' - ' + movies[index].year.toString(),
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                            ),
                                            Text(
                                              'Rating: ' + movies[index].rating.toString(),
                                              textAlign: TextAlign.center,
                                              style:
                                                  const TextStyle(fontSize: 16, decoration: TextDecoration.underline),
                                            ),
                                            Text(
                                              movies[index].genres.toString(),
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(fontSize: 16),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
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
