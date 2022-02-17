import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_flappysnakedino/bird.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // flappy bird variables
  static double birdY = 0;
  double initialPosition = birdY;
  double height = 0;
  double time = 0;
  double gravity = -4.9;
  double velocity = 3.5;

  // game settings
  bool gameStarted = false;

  // obstacles variables
  // two obstacles
  static List<double> obstacleX = [2, 2 + 1.5];
  static double barrierWidth = 0.5;
  List<List<double>> barrierHeight = [
    // max 2 where 2 is all the screen
    // [topHeight, bottomHeight]
    [0.6, 0.4],
    [0.4, 0.6],
  ];

  void startGame() {
    gameStarted = true;
    Timer.periodic(const Duration(milliseconds: 10), (timer) {
      // quadratic equation representing jump
      height = (gravity * time * time + velocity * time);
      //height = time*0.01;

      setState(() {
        // subtracting makes it go up
        birdY = initialPosition - height;
      });

      if (birdDied()) {
        timer.cancel();
        gameStarted = false;
        _showDialogBox();
      }

      // time goes on
      time += 0.01;
    });
  }

  void _showDialogBox() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.brown,
            title: const Center(
              child: Text(
                'G A M E   O V E R',
                style: TextStyle(color: Colors.white),
              ),
            ),
            actions: [
              GestureDetector(
                  onTap: resetGame,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                          padding: const EdgeInsets.all(7),
                          color: Colors.white,
                          child: const Text(
                            'P L A Y   A G A I N',
                            style: TextStyle(color: Colors.brown),
                          ))))
            ],
          );
        });
  }

  void resetGame() {
    Navigator.pop(context); // remove alert dialog
    setState(() {
      birdY = 0;
      gameStarted = false;
      time = 0;
      initialPosition = birdY;
    });
  }

  void jump() {
    setState(() {
      time = 0;
      initialPosition = birdY;
    });
  }

  bool birdDied() {
    // top or bottom of screen
    if (birdY < -1 || birdY > 1) {
      return true;
    }

    // another if: touched barriers
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: gameStarted ? jump : startGame,
      child: Scaffold(
        // divide between sky and land
        body: Column(
          children: [
            Expanded(
              // sky has bigger proportion
              flex: 3,
              child: Container(
                color: Colors.blue,
                // objects: bird and obstacles
                child: Center(
                  child: Stack(
                    children: [
                      Container(
                        alignment: Alignment(0, birdY),
                        child: const FlappyBird(),
                      ),
                      Container(
                          alignment: const Alignment(0, -0.5),
                          child: Text(
                              gameStarted
                                  ? ''
                                  : 'A P E R T E   P A R A   J O G A R',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 22)))
                    ],
                  ),
                ),
              ),
            ),
            Expanded(child: Container(color: Colors.brown))
          ],
        ),
      ),
    );
  }
}
