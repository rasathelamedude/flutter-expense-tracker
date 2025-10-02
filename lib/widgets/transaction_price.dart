import 'package:flutter/material.dart';

class MyTransactionItemPrice extends StatelessWidget {
  final double? price;

  const MyTransactionItemPrice({super.key, @required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
          width: 1,
        ),
        color: Colors.white,
      ),
      padding: EdgeInsets.all(8),
      child: Text(
        "\$${price!.toStringAsFixed(2)}",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
