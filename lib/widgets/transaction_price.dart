import 'package:flutter/material.dart';

class MyTransactionPrice extends StatelessWidget {
  final double? price;

  const MyTransactionPrice({super.key, @required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.deepPurple, width: 1),
        color: Colors.white,
      ),
      padding: EdgeInsets.all(8),
      child: Text(
        "\$$price",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20, color: Colors.deepPurple),
      ),
    );
  }
}
