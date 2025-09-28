import 'package:flutter/material.dart';

import './models/transaction_model.dart';
import './widgets/transaction_list.dart';
import './widgets/new_transaction_form.dart';
import './widgets/chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Expense Tracker",
      home: HomePage(),
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        textTheme: ThemeData.light().textTheme.copyWith(
          titleLarge: TextStyle(fontSize: 30),
        ),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
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

  List<Transaction>? get _recentTransactions {
    return userTransactions.where((tx) {
      return tx.date!.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

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
    setState(() {
      userTransactions.add(
        Transaction(
          id: userTransactions.length + 1,
          title: title,
          price: double.parse(price),
          date: DateTime.now(),
        ),
      );
    });
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
        title: Text(
          "Personal Expenses",
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Column(
        children: [
          // Chart View
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            child: Chart(recentTransactions: _recentTransactions),
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
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(Icons.add),
      ),
    );
  }
}
