import 'package:flutter/material.dart';

class FlappyBird extends StatelessWidget {
  final birdY;
  final double birdWidth;
  final double birdHeight; // max 2, 2 is entire screen

  const FlappyBird({
    Key? key,
    this.birdY,
    required this.birdWidth,
    required this.birdHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0, (2 * birdY + birdHeight) / (2 - birdHeight)),
      child: Image.asset('lib/images/flappy/flappybird.png',
          width: MediaQuery.of(context).size.height * birdWidth / 2,
          height: MediaQuery.of(context).size.height * 3 / 4 * birdHeight / 2,
          fit: BoxFit.fill),
    );
  }
}
