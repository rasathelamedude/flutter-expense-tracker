import 'package:flutter/material.dart';

class MySquarePrice extends StatelessWidget {
  final double? price;

  const MySquarePrice({super.key, @required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurple,
      child: Text(
        "$price",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
    );
  }
}
