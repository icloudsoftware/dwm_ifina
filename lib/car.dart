import 'dart:math';
import 'dart:async';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: CarRaceGame()));

class CarRaceGame extends StatefulWidget {
  @override
  _CarRaceGameState createState() => _CarRaceGameState();
}

class _CarRaceGameState extends State<CarRaceGame> {
  double carPosition = 0.5; // Position of car (from 0 to 1, where 0 is left and 1 is right)
  double carSpeed = 2.0;
  double carHeight = 80.0;
  double carWidth = 50.0;

  List<Obstacle> obstacles = [];
  late double screenWidth;
  late double screenHeight;

  int score = 0;
  bool gameOver = false;
  double obstacleSpeed = 5.0;

  // Game Timer
  Timer? gameTimer;

  @override
  void initState() {
    super.initState();
    gameTimer = Timer.periodic(Duration(milliseconds: 20), (timer) {
      setState(() {
        if (!gameOver) {
          updateGame();
        }
      });
    });
  }

  @override
  void dispose() {
    gameTimer?.cancel();
    super.dispose();
  }

  // Update the game elements like car, obstacles, and scoring
  void updateGame() {
    if (gameOver) return;

    // Move obstacles down
    obstacles.forEach((obstacle) {
      obstacle.yPosition += obstacleSpeed;
    });

    // Remove obstacles that go off the screen
    obstacles.removeWhere((obstacle) => obstacle.yPosition > screenHeight);

    // Check for collisions
    for (var obstacle in obstacles) {
      if (obstacle.collidesWith(carPosition, screenWidth)) {
        setState(() {
          gameOver = true;
        });
      }
    }

    // Add new obstacles
    if (Random().nextDouble() < 0.05) {
      obstacles.add(Obstacle(
        xPosition: Random().nextDouble(),
        yPosition: -100,
        width: 50,
        height: 50,
        color: Colors.red,
      ));
    }

    // Increase score
    score++;
  }

  // Move car with swipes or gestures
  void moveCar(DragUpdateDetails details) {
    setState(() {
      carPosition += (details.primaryDelta! / screenWidth);
      carPosition = carPosition.clamp(0.0, 1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onPanUpdate: moveCar,
        child: Stack(
          children: [
            // Road background
            Positioned.fill(
              child: Container(
                color: Colors.grey[800],
              ),
            ),
            // Car
            Positioned(
              bottom: 100,
              left: carPosition * (screenWidth - carWidth),
              child: Container(
                width: carWidth,
                height: carHeight,
                color: Colors.blue,
              ),
            ),
            // Obstacles
            ...obstacles.map((obstacle) => Positioned(
                  top: obstacle.yPosition,
                  left: obstacle.xPosition * (screenWidth - obstacle.width),
                  child: Container(
                    width: obstacle.width,
                    height: obstacle.height,
                    color: obstacle.color,
                  ),
                )),
            // Score
            Positioned(
              top: 50,
              left: 20,
              child: Text(
                "Score: $score",
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
            ),
            // Game Over Text
            if (gameOver)
              Center(
                child: Text(
                  "Game Over",
                  style: TextStyle(fontSize: 40, color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class Obstacle {
  double xPosition;
  double yPosition;
  double width;
  double height;
  Color color;

  Obstacle({required this.xPosition, required this.yPosition, required this.width, required this.height, required this.color});

  // Collision detection with car
  bool collidesWith(double carPosition, double screenWidth) {
    return (xPosition * screenWidth < carPosition * screenWidth + 50) &&
        (xPosition * screenWidth + width > carPosition * screenWidth) &&
        (yPosition < 100 + 80) &&
        (yPosition + height > 100);
  }
}
