import 'package:flutter/material.dart';

import './transaction_title_date.dart';
import './transaction_price.dart';

class MyTransactionItem extends StatelessWidget {
  final String? title;
  final DateTime? date;
  final double? price;
  final VoidCallback? deleteExpense;

  const MyTransactionItem({
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
            MyTransactionItemPrice(price: price),

            // Title and Date
            MyTransactionItemTitleDate(title: title, date: date),

            // Delete Action
            MediaQuery.of(context).size.width > 460
                ? ElevatedButton.icon(
                    onPressed: deleteExpense,
                    icon: Icon(Icons.delete, color: Colors.red, size: 28),
                    label: Text("Delete", style: TextStyle(color: Colors.red)),
                  )
                : IconButton(
                    onPressed: deleteExpense,
                    icon: Icon(Icons.delete, color: Colors.red, size: 28),
                  ),
          ],
        ),
      ),
    );
  }
}
