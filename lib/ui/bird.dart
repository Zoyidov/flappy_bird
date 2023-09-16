import 'package:flutter/material.dart';
import 'package:game/utils/icons/icons.dart';

class MyBird extends StatelessWidget {
  const MyBird(
      {super.key,
      this.birdY,
      required this.BirdHeight,
      required this.BirdWidth});

  final birdY;
  final double BirdHeight;
  final double BirdWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0, birdY),
      child: Image.asset(
        AppImages.bird,
        width: MediaQuery.of(context).size.width * BirdWidth,
        height: MediaQuery.of(context).size.height * 3 / 4 * BirdHeight,
      ),
    );
  }
}
