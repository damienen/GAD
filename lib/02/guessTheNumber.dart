import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() {
    return MyAppState();
  }
}

Random rand = Random();

class MyAppState extends State<MyApp> {
  int toGuess = 1 + rand.nextInt(100);
  int guess;
  bool guessed = false;
  bool tryHigher = false;
  TextEditingController numberGuessed = TextEditingController();
  bool pressedOkAlert = false;

// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guess my number',
      home: Scaffold(
        appBar: AppBar(title: const Text('Guess my number')),
        body: Column(
          children: <Widget>[
            const Center(
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  'I\'m thinking of a number between 1 and 100.',
                  style: TextStyle(fontSize: 23, color: Colors.black, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const Center(
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  'It\'s your turn to guess my number!',
                  style: TextStyle(fontSize: 15, color: Colors.black, fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Visibility(
              visible: guessed,
              child: Center(
                child: Text(
                  'You tried $guess',
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Visibility(
              visible: guessed,
              child: Center(
                child: Text(
                  tryHigher ? 'Try higher' : 'Try lower',
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Card(
                  margin: const EdgeInsets.all(5),
                  shadowColor: Colors.black,
                  elevation: 10,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Center(
                          child: Padding(
                        child: Text('Try a number!',
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.grey,
                            )),
                        padding: EdgeInsets.all(5),
                      )),
                      Center(
                          child: Padding(
                              padding: const EdgeInsets.only(bottom: 15, left: 5, right: 5),
                              child: TextField(
                                controller: numberGuessed,
                                style: const TextStyle(fontSize: 20, color: Colors.black),
                                textAlign: TextAlign.center,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(RegExp(r'^[1-9][0-9]?$|^100$'))
                                ],
                                keyboardType: TextInputType.number,
                                enabled: !pressedOkAlert,
                              ))),
                      Center(
                          child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: RaisedButton(
                                child: Text(pressedOkAlert ? 'RESET' : 'GUESS', style: const TextStyle(fontSize: 15)),
                                color: pressedOkAlert ? Colors.grey : Colors.blue,
                                onPressed: () {
                                  if (!pressedOkAlert) {
                                    if (numberGuessed.text.isNotEmpty)
                                      setState(() {
                                        guess = int.parse(numberGuessed.text);
                                        guessed = true;
                                        if (guess != toGuess) {
                                          tryHigher = guess < toGuess;
                                        } else {
                                          showDialog<void>(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Text('You guessed right!'),
                                                  content: Text('It was $toGuess'),
                                                  actions: <Widget>[
                                                    FlatButton(
                                                      child: const Text('Try Again'),
                                                      onPressed: () {
                                                        toGuess = 1 + rand.nextInt(100);
                                                        setState(() {
                                                          numberGuessed.clear();
                                                          guessed = false;
                                                          guess = null;
                                                          pressedOkAlert = false;
                                                          Navigator.of(context, rootNavigator: true).pop();
                                                        });
                                                      },
                                                    ),
                                                    FlatButton(
                                                      child: const Text('OK'),
                                                      onPressed: () {
                                                        pressedOkAlert = true;
                                                        setState(() {
                                                          guessed = false;
                                                          Navigator.of(context, rootNavigator: true).pop();
                                                        });
                                                      },
                                                    ),
                                                  ],
                                                );
                                              });
                                        }
                                      });
                                  } else {
                                    toGuess = 1 + rand.nextInt(100);
                                    setState(() {
                                      numberGuessed.clear();
                                      guessed = false;
                                      guess = null;
                                      pressedOkAlert = false;
                                    });
                                  }
                                },
                              )))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
