import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      home: Scaffold(
        appBar: AppBar(title: const Text('Tic Tac Toe')),
        body: GridView.builder(
          itemCount: 12,
          padding: const EdgeInsets.all(5),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemBuilder: (BuildContext context, int index) {
            if (index < 9) {
              return AnimatedContainer(
                decoration: BoxDecoration(
                  color: gameState[index],
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  border: Border.all(color: Colors.black, width: 5),
                ),
                duration: const Duration(milliseconds: 350),
                child: FlatButton(
                  onPressed: () {
                    setState(() {
                      if (gameState[index] == Colors.white) {
                        gameState[index] = greenTurn ? Colors.green : Colors.red;
                        greenTurn = !greenTurn;
                      }
                      isGameOver();
                    });
                  },
                  child: null,
                ),
              );
            } else if (index == 10) {
              return Container(
                alignment: Alignment.topCenter,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Visibility(
                  visible: isGameOver(),
                  child: RaisedButton(
                    child: const Text(
                      'Play again',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {
                      setState(() {
                        gameState.fillRange(0, gameState.length, Colors.white);
                        greenTurn = true;
                      });
                    },
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}

bool greenTurn = true;

//This list contains the state of a game. White means no move on that tile yet. Green means player 1 moved. Red means player 2 moved.
List<Color> gameState = <Color>[
  Colors.white, //R0C0->index0
  Colors.white, //R0C1->index1
  Colors.white, //R0C2->index2
  Colors.white, //R1C0->index3
  Colors.white, //R1C1->index4
  Colors.white, //R1C2->index5
  Colors.white, //R2C0->index6
  Colors.white, //R2C1->index7
  Colors.white, //R2C2->index8
];

//This method checks whether the game is finished and if it is it signals the winning move
bool isGameOver() {
  //Checking each row
  if (gameState[0] == gameState[1] && gameState[1] == gameState[2] && gameState[2] != Colors.white) {
    for (int i = 0; i < gameState.length; i++) {
      if (i != 0 && i != 1 && i != 2) {
        gameState[i] = Colors.white;
      }
    }
    return true;
  }
  if (gameState[3] == gameState[4] && gameState[4] == gameState[5] && gameState[5] != Colors.white) {
    for (int i = 0; i < gameState.length; i++) {
      if (i != 3 && i != 4 && i != 5) {
        gameState[i] = Colors.white;
      }
    }
    return true;
  }
  if (gameState[6] == gameState[7] && gameState[7] == gameState[8] && gameState[8] != Colors.white) {
    for (int i = 0; i < gameState.length; i++) {
      if (i != 6 && i != 7 && i != 8) {
        gameState[i] = Colors.white;
      }
    }
    return true;
  }
  //Checking each column
  if (gameState[0] == gameState[3] && gameState[3] == gameState[6] && gameState[6] != Colors.white) {
    for (int i = 0; i < gameState.length; i++) {
      if (i != 0 && i != 3 && i != 6) {
        gameState[i] = Colors.white;
      }
    }
    return true;
  }
  if (gameState[1] == gameState[4] && gameState[4] == gameState[7] && gameState[7] != Colors.white) {
    for (int i = 0; i < gameState.length; i++) {
      if (i != 1 && i != 4 && i != 7) {
        gameState[i] = Colors.white;
      }
    }
    return true;
  }
  if (gameState[2] == gameState[5] && gameState[5] == gameState[8] && gameState[8] != Colors.white) {
    for (int i = 0; i < gameState.length; i++) {
      if (i != 2 && i != 5 && i != 8) {
        gameState[i] = Colors.white;
      }
    }
    return true;
  }
  //Checking diagonals
  if (gameState[0] == gameState[4] && gameState[4] == gameState[8] && gameState[8] != Colors.white) {
    for (int i = 0; i < gameState.length; i++) {
      if (i != 0 && i != 4 && i != 8) {
        gameState[i] = Colors.white;
      }
    }
    return true;
  }
  if (gameState[2] == gameState[4] && gameState[4] == gameState[6] && gameState[6] != Colors.white) {
    for (int i = 0; i < gameState.length; i++) {
      if (i != 3 && i != 4 && i != 6) {
        gameState[i] = Colors.white;
      }
    }
    return true;
  }

  if (!gameState.contains(Colors.white)) {
    return true;
  }
  return false;
}
