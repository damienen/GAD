import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:powers/powers.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  TextEditingController numberInput = TextEditingController();

// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Number Shapes',
        home: Scaffold(
            appBar: AppBar(title: const Text('Number Shapes')),
            body: Column(
              children: <Widget>[
                const Padding(
                    padding: EdgeInsets.all(5),
                    child: Text('Please input a number to see if it is a square or a triangular')),
                Padding(
                    padding: const EdgeInsets.all(15),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^[0-9]*$'))],
                      style: const TextStyle(fontSize: 20, color: Colors.black),
                      textAlign: TextAlign.center,
                      controller: numberInput,
                    ))
              ],
            ),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                if (numberInput.text.isNotEmpty) {
                  int nr = int.parse(numberInput.text);
                  String alertText = '';
                  if (nr.isSquare) alertText += '$nr is a SQUARE';
                  if (nr.isCube) alertText += '\n$nr is a CUBE';
                  showDialog<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            title: Text(alertText.isEmpty ? '$nr is neither a CUBE or a SQUARE' : alertText));
                      });
                  numberInput.clear();
                }
              },
              elevation: 5,
              icon: const Icon(Icons.where_to_vote_rounded),
              backgroundColor: Colors.blueGrey,
              splashColor: Colors.blue,
              label: const Text('CALCULATE'),
            )));
  }
}
