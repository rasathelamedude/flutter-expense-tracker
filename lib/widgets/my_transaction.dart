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
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Padding(
        padding: EdgeInsetsGeometry.all(5),
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
              icon: Icon(Icons.delete, color: Colors.red, size: 28),
            ),
          ],
        ),
      ),
    );
  }
}
