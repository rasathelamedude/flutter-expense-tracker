import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyTransactionItemTitleDate extends StatelessWidget {
  final String? title;
  final DateTime? date;

  const MyTransactionItemTitleDate({
    super.key,
    @required this.title,
    @required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title!,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        Text(
          DateFormat().format(date!),
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
      ],
    );
  }
}
