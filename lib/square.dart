import 'package:flutter/material.dart';

import './square.content.dart';

class MySquare extends StatelessWidget {
  final String? title;
  final String? date;
  final double? price;
  final VoidCallback? deleteExpense;

  const MySquare({
    super.key,
    @required this.title,
    @required this.date,
    @required this.price,
    @required this.deleteExpense,
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
      height: 65,
      margin: EdgeInsets.symmetric(vertical: 12),
      padding: EdgeInsets.all(4),
      child: MySquareContent(
        price: price,
        title: title,
        date: date,
        deleteExpense: deleteExpense,
      ),
    );
  }
}
