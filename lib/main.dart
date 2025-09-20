import 'package:expenss_tracker/widgets/new_transaction_form.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import './models/transaction_model.dart';
import './widgets/transaction_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "Expenss Tracker", home: HomePage());
  }
}

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> userTransactions = [
    Transaction(id: 1, title: "Title 1", price: 10.99, date: DateTime.now()),
    Transaction(id: 2, title: "Title 2", price: 15.99, date: DateTime.now()),
    Transaction(id: 3, title: "Title 3", price: 20.99, date: DateTime.now()),
  ];

  void _startAddExpense() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return TransactionForm(addTransaction: addTransaction);
      },
    );
  }

  void addTransaction(title, price) {
    userTransactions.add(
      Transaction(
        id: userTransactions.length + 1,
        title: title,
        price: double.parse(price),
        date: DateTime.now(),
      ),
    );
  }

  void deleteTransaction(index) {
    setState(() {
      userTransactions.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Personal Expenses", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          // Chart View
          Container(
            height: 200,
            margin: EdgeInsets.symmetric(vertical: 5),
            child: BarChart(BarChartData()),
          ),

          // Expense List View
          Expanded(
            child: TransactionList(
              userTransactions: userTransactions,
              deleteExpense: deleteTransaction,
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _startAddExpense,
        child: Icon(Icons.add),
      ),
    );
  }
}
