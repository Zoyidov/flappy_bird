import 'package:flutter/material.dart';

class MyBarrier extends StatelessWidget {
  final size;

  const MyBarrier({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: size,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.green,
          border: Border.all(color: Colors.white, width: 5)),
    );
  }
}
