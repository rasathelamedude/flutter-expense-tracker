import 'dart:math';

import 'package:flutter/material.dart';

import './transaction_title_date.dart';
import './transaction_price.dart';

class MyTransactionItem extends StatefulWidget {
  final String? title;
  final DateTime? date;
  final double? price;
  final VoidCallback? deleteExpense;

  const MyTransactionItem({
    required Key key,
    @required this.title,
    @required this.date,
    @required this.price,
    @required this.deleteExpense,
  }) : super(key: key);

  @override
  State<MyTransactionItem> createState() => _MyTransactionItemState();
}

class _MyTransactionItemState extends State<MyTransactionItem> {
  Color? _priceColor;

  @override
  void initState() {
    const availableColors = [
      Colors.blue,
      Colors.yellow,
      Colors.deepPurple,
      Colors.red,
    ];

    _priceColor = availableColors[Random().nextInt(4)];
    super.initState();
  }

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
            // Price;
            MyTransactionItemPrice(
              price: widget.price,
              priceColor: _priceColor,
            ),

            // Title and Date
            MyTransactionItemTitleDate(title: widget.title, date: widget.date),

            // Delete Button
            MediaQuery.of(context).size.width > 460
                ? ElevatedButton.icon(
                    onPressed: widget.deleteExpense,
                    icon: Icon(Icons.delete, color: Colors.red, size: 28),
                    label: Text("Delete", style: TextStyle(color: Colors.red)),
                  )
                : IconButton(
                    onPressed: widget.deleteExpense,
                    icon: Icon(Icons.delete, color: Colors.red, size: 28),
                  ),
          ],
        ),
      ),
    );
  }
}
