import 'package:flutter/material.dart';

class FlappyBird extends StatelessWidget {
  const FlappyBird({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Image.asset('lib/images/flappy/flappybird.png', width: 75, height: 75),
    );
  }
}
