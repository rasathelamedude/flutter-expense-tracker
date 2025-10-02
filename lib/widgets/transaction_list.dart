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
        : ListView(
            children: [
              ...userTransactions!.map(
                (transaction) => MyTransactionItem(
                  key: ValueKey(transaction.id),
                  title: transaction.title,
                  date: transaction.date,
                  price: transaction.price,
                  deleteExpense: () => deleteExpense!((transaction.id! - 1)),
                ),
              ),
            ],
          );
  }
}
