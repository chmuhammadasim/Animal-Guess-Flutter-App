import 'package:flutter/material.dart';

import 'constants/list.dart';

void main() {
  runApp(const PhotoQuizApp());
}

class PhotoQuizApp extends StatelessWidget {
  const PhotoQuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guess the Pictures',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PhotoQuizScreen(),
    );
  }
}

class PhotoQuizScreen extends StatefulWidget {
  const PhotoQuizScreen({super.key});

  @override
  _PhotoQuizScreenState createState() => _PhotoQuizScreenState();
}

class _PhotoQuizScreenState extends State<PhotoQuizScreen> {
  int currentPictureIndex = 0;
  int score = 0;
  TextEditingController guessController = TextEditingController();

  void checkAnswer(String guess) {
    String answer = animalsNameList[currentPictureIndex];
    if (guess.toLowerCase() == answer.toLowerCase()) {
      setState(() {
        score++;
        guessController.clear();
        if (currentPictureIndex < animalsPicList.length - 1) {
          currentPictureIndex++;
        } else {
          // Game Over
          _showGameOverDialog();
        }
      });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Wrong Answer!'),
            content: const Text('Please try again.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  void _showGameOverDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Game Over'),
          content: Text('Final Score: $score'),
          actions: <Widget>[
            TextButton(
              child: const Text('Restart'),
              onPressed: () {
                setState(() {
                  currentPictureIndex = 0;
                  score = 0;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guess the Pictures'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            animalsPicList[currentPictureIndex],
            width: 200,
            height: 200,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: guessController,
              decoration: const InputDecoration(
                labelText: 'Enter your guess',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              String guess = guessController.text;
              checkAnswer(guess);
            },
            child: const Text('Submit'),
          ),
          const SizedBox(height: 20),
          Text(
            'Score: $score',
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
