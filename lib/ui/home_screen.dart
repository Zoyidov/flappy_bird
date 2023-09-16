import 'dart:async';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:game/ui/barrier.dart';
import 'package:game/ui/bird.dart';
import 'package:game/ui/widget/circles.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double birdY = 0;
  double initialPosition = birdY;
  double height = 0;
  double time = 0;
  double gravity = -4.9;
  double velocity = 2.8;
  double BirdHeight = 0.1;
  double BirdWidth = 0.1;
  static double barrierXone = 1;
  double barrierXtwo = barrierXone + 1.5;

  bool gameHasStarted = false;
  static List<double> BarrierX = [2, 2 + 1.5];
  static double BarrierWidth = 0.5;
  List<List<double>> BarrierHeight = [
    [0.6, 0.4],
    [0.4, 0.6]
  ];

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(
      Duration(milliseconds: 2),
      (timer) {
        time += 0.0015;
        height = gravity * time * time + velocity * time;
        setState(() {
          birdY = initialPosition - height;
        });

        setState(() {
          if (barrierXone < -2){
            barrierXone += 3.5;
          }else{
            barrierXone -= 0.01;
          }
        });

        setState(() {
          if (barrierXtwo < -2){
            barrierXtwo += 3.5;
          }else{
            barrierXtwo -= 0.01;
          }
        });

        if (birdIsDead()) {
          timer.cancel();
          gameHasStarted = false;
          _showDialog(context);
        }

        if (birdY < -1 || birdY > 1) {
          timer.cancel();
        }
      },
    );
  }

  void jump() {
    time = 0.03;
    initialPosition = birdY;
  }

  bool birdIsDead() {
    if (birdY < -1 || birdY > 1 || birdY == barrierXone-1 || birdY == barrierXtwo) {
      return true;
    }
    for (int i = 0; i < BarrierX.length; i++) {
      if (BarrierX[i] <= BirdWidth &&
          BarrierX[i] + BarrierWidth >= -BirdWidth &&
          (birdY <= -1 + BarrierHeight[i][0] ||
              birdY + BirdHeight >= 1 - BarrierHeight[i][1])) {
        return true;
      }
    }
    return false;
  }

  void resetGame() {
    Navigator.pop(context);
    setState(() {
      birdY = 0.1;
      gameHasStarted = false;
      time = 0;
      barrierXone = 1;
      barrierXtwo = barrierXone + 1.5;
      initialPosition = birdY;
    });
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.brown,
          title: Center(
            child: Text(
              "GAME OVER",
              style: TextStyle(color: Colors.white),
            ),
          ),
          actions: [
            GestureDetector(
              onTap: resetGame,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  padding: EdgeInsets.all(7),
                  color: Colors.white,
                  child: Text(
                    'PLAY AGAIN',
                    style: TextStyle(color: Colors.brown),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: gameHasStarted ? jump : startGame,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.blue,
                child: Center(
                  child: Stack(
                    children: [
                      MyBird(
                        birdY: birdY,
                        BirdHeight: BirdHeight,
                        BirdWidth: BirdWidth,
                      ),
                      AnimatedContainer(
                        alignment: Alignment(barrierXone,1.1),
                        duration: Duration(milliseconds: 0),
                        child: MyBarrier(
                          size: 200.0,
                        ),
                      ),
                      AnimatedContainer(
                        alignment: Alignment(barrierXone,-1.1),
                        duration: Duration(milliseconds: 0),
                        child: MyBarrier(
                          size: 200.0,
                        ),
                      ),
                      AnimatedContainer(
                        alignment: Alignment(barrierXtwo,1.1),
                        duration: Duration(milliseconds: 0),
                        child: MyBarrier(
                          size: 150.0,
                        ),
                      ),
                      AnimatedContainer(
                        alignment: Alignment(barrierXtwo,-1.1),
                        duration: Duration(milliseconds: 0),
                        child: MyBarrier(
                          size: 250.0,
                        ),
                      ),
                      Container(
                        alignment: Alignment(0, -0.5),
                        child: Text(
                          gameHasStarted ? '' : 'Tap to Play',
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 10,
              color: Colors.green,
            ),
            Expanded(
              child: Container(
                color: Colors.brown,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
