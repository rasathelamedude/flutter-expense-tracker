import 'package:flutter/material.dart';

import './transaction_title_date.dart';
import './transaction_price.dart';

class MyTransaction extends StatelessWidget {
  final String? title;
  final DateTime? date;
  final double? price;
  final VoidCallback? deleteExpense;

  const MyTransaction({
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Price
          MyTransactionPrice(price: price),

          // Title and Date
          MyTransactionTitleDate(title: title, date: date),

          // Delete Action
          IconButton(
            onPressed: deleteExpense,
            icon: Icon(Icons.delete, color: Colors.red, size: 24),
          ),
        ],
      ),
    );
  }
}
