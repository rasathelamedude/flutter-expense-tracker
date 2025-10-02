import 'package:flutter/material.dart';

import '../models/transaction_model.dart';
import './transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction>? userTransactions;
  final void Function(int)? deleteExpense;

  const TransactionList({super.key, this.userTransactions, this.deleteExpense});

  @override
  Widget build(BuildContext context) {
    return userTransactions!.isEmpty
        ? LayoutBuilder(
            builder: (context, constraints) {
              return Center(child: Text("No transactions to display..."));
            },
          )
        : ListView.builder(
            itemCount: userTransactions!.length,
            itemBuilder: (context, index) => MyTransactionItem(
              title: userTransactions![index].title,
              date: userTransactions![index].date,
              price: userTransactions![index].price,
              deleteExpense: () => deleteExpense!(index),
            ),
          );
  }
}
