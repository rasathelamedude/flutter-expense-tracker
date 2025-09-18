import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import './my_transaction.dart';
import './transaction_model.dart';

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
  final List<Transaction> _transactions = [
    Transaction(id: "1", title: "Title 1", price: 10.99, date: DateTime.now()),
    Transaction(id: "2", title: "Title 2", price: 15.99, date: DateTime.now()),
    Transaction(id: "3", title: "Title 3", price: 20.99, date: DateTime.now()),
  ];

  void deleteExpense(index) {
    setState(() {
      _transactions.removeAt(index);
    });
  }

  void _startAddExpense() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return Padding(
          padding: EdgeInsetsGeometry.only(
            top: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom,
            right: 16,
            left: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Text Fields
              TextField(decoration: InputDecoration(labelText: "Expense Name")),
              TextField(
                decoration: InputDecoration(labelText: "Expense Date"),
                keyboardType: TextInputType.datetime,
              ),
              TextField(
                decoration: InputDecoration(labelText: "Amount Spent"),
                keyboardType: TextInputType.number,
              ),

              // Space
              const SizedBox(height: 20),

              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Cancel"),
                  ),

                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Add"),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
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
            child: ListView.builder(
              itemCount: _transactions.length,
              itemBuilder: (context, index) => MyTransaction(
                title: _transactions[index].title,
                date: _transactions[index].date,
                price: _transactions[index].price,
                deleteExpense: () => deleteExpense(index),
              ),
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
