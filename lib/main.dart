import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  TextEditingController valueToConvert = TextEditingController();
  int validInput = 0;
  double convertedValue;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Currency converter',
        home: Scaffold(
            appBar: AppBar(title: const Text('Currency converter')),
            body: Column(
              children: <Widget>[
                Image.network('https://www.nationsonline.org/gallery/World/currencies.jpg'),
                Padding(
                    padding: EdgeInsets.all(20),
                    // ignore: prefer_const_constructors
                    child: TextField(
                      controller: valueToConvert,
                      style: const TextStyle(fontSize: 20, color: Colors.black),
                      textAlign: TextAlign.center,
                      // ignore: prefer_const_constructors
                      decoration: InputDecoration(
                        hintText: 'enter the amount of EUR to convert',
                        errorText: validInput == 0 || validInput == 2 ? null : 'Value cannot be empty!',
                      ),
                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d*'))],
                      keyboardType: const TextInputType.numberWithOptions(signed: false, decimal: true),
                    )),
                RaisedButton(
                  onPressed: () async {
                    validInput = validateText(valueToConvert.text);
                    if (validInput == 2) {
                      await convertValue(valueToConvert.text);
                    }
                    setState(() {});
                  },
                  child: Text('CONVERT'),
                  color: Colors.blue,
                ),
                Visibility(
                    visible: validInput == 2,
                    child: Padding(
                        padding: EdgeInsets.all(20),
                        // ignore: prefer_const_constructors
                        child: Text(
                          '$convertedValue',
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 50, color: Colors.black54),
                        )))
              ],
            )));
  }

  int validateText(String text) {
    if (valueToConvert.text.isEmpty || valueToConvert.text == '.')
      return 1;
    else
      return 2;
  }

  void convertValue(String text) async {
    const url = 'https://api.exchangeratesapi.io/latest?symbols=RON';
    var response = await http.get(url);
    dynamic jsonResponse = convert.jsonDecode(response.body);
    convertedValue = double.parse(jsonResponse['rates']['RON'].toString()) * double.parse(text);
  }
}
