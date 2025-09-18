import 'package:flutter/material.dart';

class MyTransactionTitleDate extends StatelessWidget {
  final String? title;
  final DateTime? date;

  const MyTransactionTitleDate({
    super.key,
    @required this.title,
    @required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title!,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Text(
          "$date",
          style: TextStyle(
            color: const Color.fromARGB(255, 94, 94, 94),
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
