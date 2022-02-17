import 'package:flutter/material.dart';

class Obstacle extends StatelessWidget {
  // width is max 2, since it begins at -1 and goes to +1
  final obstacleWidth;
  final obstacleHeight;
  final obstacleX;
  final bool isObstacleBottom;

  const Obstacle(
      {Key? key,
      this.obstacleWidth,
      this.obstacleHeight,
      this.obstacleX,
      required this.isObstacleBottom})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(
          (2 * obstacleX + obstacleWidth) / (2 - obstacleWidth),
          isObstacleBottom ? 1 : -1),
      child: Container(
        color: Colors.green,
        // prefer mediaquery to use proportions rather than fixed sizes
        width: MediaQuery.of(context).size.width * obstacleWidth / 2,
        height: MediaQuery.of(context).size.height * 3 / 4 * obstacleHeight / 2,
      ),
    );
  }
}
