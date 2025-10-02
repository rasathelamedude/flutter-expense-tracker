import 'package:flutter/material.dart';

class MyTransactionItemPrice extends StatelessWidget {
  final double? price;
  final Color? priceColor;

  const MyTransactionItemPrice({
    super.key,
    @required this.price,
    @required this.priceColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: priceColor as Color, width: 1),
        color: Colors.white,
      ),
      padding: EdgeInsets.all(8),
      child: Text(
        "\$${price!.toStringAsFixed(2)}",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20, color: priceColor),
      ),
    );
  }
}
