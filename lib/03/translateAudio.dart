import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

final AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();
const List<String> expressions = <String>[
  'Salut!',
  'Hallo!',
  'Cum te numești?',
  'Wie heißen Sie?',
  'Numele meu este',
  'Mein Name ist',
  'Cum ești?',
  'Wie gehts?',
  'Sunt foarte bine.',
  'Ich bin sehr gut.',
  'La revedere!',
  'Auf Wiedersehen!'
];

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
      title: 'Basic translator',
      home: Scaffold(
        appBar: AppBar(title: const Text('Basic translator')),
        body: GridView.builder(
          itemCount: 12,
          padding: const EdgeInsets.all(10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                border: Border.all(color: Colors.blueGrey, width: 2),
              ),
              child: Center(
                child: TextButton(
                  child: Text(
                    expressions[index],
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  onPressed: () {
                    assetsAudioPlayer.open(
                      Audio('assets/audio/expression' + index.toString() + '.mp3'),
                      forceOpen: true,
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
