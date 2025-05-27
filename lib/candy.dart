import 'dart:math';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';

void main() => runApp(CandyCrushApp());

class CandyCrushApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          home: CandyCrushGame(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}

class CandyCrushGame extends StatefulWidget {
  @override
  _CandyCrushGameState createState() => _CandyCrushGameState();
}

class _CandyCrushGameState extends State<CandyCrushGame> {
  static const int gridSize = 8;
  static const List<Color> candyColors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.purple,
  ];

  List<List<Color>> grid = List.generate(
    gridSize,
    (_) => List.generate(
      gridSize,
      (_) => candyColors[Random().nextInt(candyColors.length)],
    ),
  );

  Set<Offset> toBlast = {};
  List<List<bool>>? isBlasting;

  @override
  void initState() {
    super.initState();
    checkMatches();
    isBlasting =
        List.generate(gridSize, (_) => List.generate(gridSize, (_) => false));
  }

  void swapTiles(int row1, int col1, int row2, int col2) {
    final temp = grid[row1][col1];
    grid[row1][col1] = grid[row2][col2];
    grid[row2][col2] = temp;

    if (_hasMatch()) {
      setState(() {
        checkMatches();
      });
    } else {
      // Revert swap
      final revert = grid[row1][col1];
      grid[row1][col1] = grid[row2][col2];
      grid[row2][col2] = revert;
    }
  }

  bool _hasMatch() {
    for (int row = 0; row < gridSize; row++) {
      for (int col = 0; col < gridSize - 2; col++) {
        final color = grid[row][col];
        if (color != Colors.transparent &&
            grid[row][col + 1] == color &&
            grid[row][col + 2] == color) {
          return true;
        }
      }
    }

    for (int col = 0; col < gridSize; col++) {
      for (int row = 0; row < gridSize - 2; row++) {
        final color = grid[row][col];
        if (color != Colors.transparent &&
            grid[row + 1][col] == color &&
            grid[row + 2][col] == color) {
          return true;
        }
      }
    }

    return false;
  }

  void checkMatches() {
    final matches = <Offset>{};

    // Horizontal
    for (int row = 0; row < gridSize; row++) {
      for (int col = 0; col < gridSize - 2; col++) {
        final color = grid[row][col];
        if (color != Colors.transparent &&
            grid[row][col + 1] == color &&
            grid[row][col + 2] == color) {
          matches.addAll([
            Offset(row.toDouble(), col.toDouble()),
            Offset(row.toDouble(), col + 1.0),
            Offset(row.toDouble(), col + 2.0),
          ]);
        }
      }
    }

    // Vertical
    for (int col = 0; col < gridSize; col++) {
      for (int row = 0; row < gridSize - 2; row++) {
        final color = grid[row][col];
        if (color != Colors.transparent &&
            grid[row + 1][col] == color &&
            grid[row + 2][col] == color) {
          matches.addAll([
            Offset(row.toDouble(), col.toDouble()),
            Offset(row + 1.0, col.toDouble()),
            Offset(row + 2.0, col.toDouble()),
          ]);
        }
      }
    }

    if (matches.isNotEmpty) {
      setState(() {
        toBlast = matches;
      });

      Future.delayed(Duration(milliseconds: 300), () {
        setState(() {
          for (final offset in toBlast) {
            isBlasting![offset.dx.toInt()][offset.dy.toInt()] = true;
          }
        });

        Future.delayed(Duration(milliseconds: 300), () {
          setState(() {
            for (final offset in toBlast) {
              grid[offset.dx.toInt()][offset.dy.toInt()] = Colors.transparent;
              isBlasting![offset.dx.toInt()][offset.dy.toInt()] = false;
            }
            toBlast.clear();
          });

          Future.delayed(Duration(milliseconds: 200), () {
            setState(() {
              dropCandies();
              refillCandies();
              checkMatches();
            });
          });
        });
      });
    }
  }

  void dropCandies() {
    for (int col = 0; col < gridSize; col++) {
      for (int row = gridSize - 1; row >= 0; row--) {
        if (grid[row][col] == Colors.transparent) {
          for (int k = row - 1; k >= 0; k--) {
            if (grid[k][col] != Colors.transparent) {
              grid[row][col] = grid[k][col];
              grid[k][col] = Colors.transparent;
              break;
            }
          }
        }
      }
    }
  }

  void refillCandies() {
    for (int row = 0; row < gridSize; row++) {
      for (int col = 0; col < gridSize; col++) {
        if (grid[row][col] == Colors.transparent) {
          grid[row][col] = candyColors[Random().nextInt(candyColors.length)];
        }
      }
    }
  }

  Widget buildTile(Color color, bool isBlasting) {
    return AnimatedScale(
      scale: isBlasting ? 0.0 : 1.0,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInBack,
      child: AnimatedOpacity(
        opacity: isBlasting ? 0.0 : 1.0,
        duration: Duration(milliseconds: 300),
        child: Container(
          margin: EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black12),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Candy Crush Clone')),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 5.h),
            Expanded(
              child: GridView.builder(
                itemCount: gridSize * gridSize,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: gridSize,
                ),
                itemBuilder: (context, index) {
                  final row = index ~/ gridSize;
                  final col = index % gridSize;
                  final color = grid[row][col];
                  final blasting = isBlasting?[row][col] ?? false;

                  return GestureDetector(
                    onPanUpdate: (details) {
                      int newRow = row;
                      int newCol = col;
                      if (details.delta.dx.abs() > details.delta.dy.abs()) {
                        newCol += details.delta.dx > 0 ? 1 : -1;
                      } else {
                        newRow += details.delta.dy > 0 ? 1 : -1;
                      }

                      if (newRow >= 0 &&
                          newRow < gridSize &&
                          newCol >= 0 &&
                          newCol < gridSize) {
                        swapTiles(row, col, newRow, newCol);
                      }
                    },
                    child: buildTile(color, blasting),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
