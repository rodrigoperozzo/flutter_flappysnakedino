import 'dart:async';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double birdY = 0;
  
  void jump() {
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      setState(() {
        // subtracting makes it go up
        birdY -= 0.05;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: jump,
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
                        child: Container(
                          width: 50,
                          height: 50,
                          color: Colors.yellow,
                        ),
                      )
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


