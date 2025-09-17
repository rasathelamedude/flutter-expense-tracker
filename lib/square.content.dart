import 'package:flutter/material.dart';

import './square.price.dart';
import './square.title.dart';

class MySquareContent extends StatelessWidget {
  final String? title;
  final String? date;
  final double? price;

  const MySquareContent({
    super.key,
    @required this.price,
    @required this.title,
    @required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Price
        MySquarePrice(price: price),

        // Title and Date
        MySquareTitle(title: title, date: date),

        // Delete Action
        Icon(Icons.delete, size: 28, color: Colors.red),
      ],
    );
  }
}
