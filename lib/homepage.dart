import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_flappysnakedino/bird.dart';
import 'package:flutter_flappysnakedino/obstacle.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // flappy bird variables
  // the good part of having all these variables declared here
  // is that everything from the game can be controlled and manipulated
  // and almost all sizes are proportions so can work based on screen size
  static double birdY = 0;
  double initialPosition = birdY;
  double height = 0;
  double time = 0;
  double gravity = -4.9;
  double velocity = 1.5;
  double birdWidth = 0.20;
  double birdHeight = 0.25;

  // game settings
  bool gameStarted = false;

  // obstacles variables
  // two obstacles
  static List<double> obstacleX = [2, 2 + 1.5];
  static double obstacleWidth = 0.5;
  List<List<double>> obstacleHeight = [
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

      moveMap();

      // time goes on
      time += 0.01;
    });
  }

  void moveMap() {
    for (int i = 0; i < obstacleX.length; i++) {
      setState(() {
        obstacleX[i] -= 0.005;
      });

      if (obstacleX[i] < -1.5) {
        obstacleX[i] += 3;
      }
    }
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

    // hits barrier
    for (int i = 0; i < obstacleX.length; i++) {
      if (obstacleX[i] <= birdWidth &&
          obstacleX[i] + obstacleWidth >= -birdWidth &&
          (birdY <= -1 + obstacleHeight[i][0] ||
              birdY + birdHeight >= 1 - obstacleHeight[i][1])) {
        return true;
      }
    }

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
                      FlappyBird(
                        birdY: birdY,
                        birdHeight: birdHeight,
                        birdWidth: birdWidth,
                      ),
                      Container(
                          alignment: const Alignment(0, -0.5),
                          child: Text(
                              gameStarted
                                  ? ''
                                  : 'A P E R T E   P A R A   J O G A R',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 22))),

                      // top obstacle 0
                      Obstacle(
                          isObstacleBottom: false,
                          obstacleX: obstacleX[0],
                          obstacleWidth: obstacleWidth,
                          obstacleHeight: obstacleHeight[0][0]),

                      // bottom obstacle 0
                      Obstacle(
                          isObstacleBottom: true,
                          obstacleX: obstacleX[0],
                          obstacleWidth: obstacleWidth,
                          obstacleHeight: obstacleHeight[0][1]),

                      // top obstacle 1
                      Obstacle(
                          isObstacleBottom: false,
                          obstacleX: obstacleX[1],
                          obstacleWidth: obstacleWidth,
                          obstacleHeight: obstacleHeight[1][0]),

                      // bottom obstacle 1
                      Obstacle(
                          isObstacleBottom: true,
                          obstacleX: obstacleX[1],
                          obstacleWidth: obstacleWidth,
                          obstacleHeight: obstacleHeight[1][1])
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
