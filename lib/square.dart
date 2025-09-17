import 'package:flutter/material.dart';

import './square.content.dart';

class MySquare extends StatelessWidget {
  final String? title;
  final String? date;
  final double? price;

  const MySquare({
    super.key,
    @required this.title,
    @required this.date,
    @required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 242, 242, 242),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 96, 96, 96),
            blurRadius: 2,
            spreadRadius: 2,
          ),
        ],
      ),
      width: double.infinity,
      margin: EdgeInsets.all(2),
      padding: EdgeInsets.all(4),
      child: MySquareContent(price: price, title: title, date: date),
    );
  }
}
