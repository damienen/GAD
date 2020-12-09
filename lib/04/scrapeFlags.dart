import 'package:flutter/material.dart';
import 'package:http/http.dart';

//TEMA: API cu movies, sa poti sorta movies dupa o categorie,
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  final List<String> _countries = <String>[];
  final List<String> _flags = <String>[];

  @override
  void initState() {
    super.initState();
    _getCountries();
  }

  Future<void> _getCountries() async {
    final Response response = await get('https://www.worldometers.info/geography/flags-of-the-world/');
    final String data = response.body;
    final List<String> items = data.split('<a href="/img/flags');
    const String countryTitlePattern = 'padding-top:10px">';
    for (final String item in items.skip(1)) {
      final String country =
          item.substring(item.indexOf(countryTitlePattern) + countryTitlePattern.length, item.indexOf('</div>'));
      final String flag = 'https://www.worldometers.info/img/flags${item.split('"')[0]}';
      _countries.add(country);
      _flags.add(flag);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flag scraping',
      home: Scaffold(
        appBar: AppBar(title: const Text('Flag scraping')),
        body: GridView.builder(
            itemCount: _countries.length,
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemBuilder: (BuildContext context, int index) {
              return Image.network(
                _flags[index],
                fit: BoxFit.fill,
              );
            }),
      ),
    );
  }
}
