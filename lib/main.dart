import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import './square.dart';

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
  final List<Map<String, Object>> _expenses = [
    {"title": "expense 1", "date": "May, 28, 2019", "price": 17.99},
    {"title": "expense 2", "date": "July, 30, 2019", "price": 9.99},
    {"title": "expense 3", "date": "Apr, 15, 2019", "price": 25.99},
    {"title": "expense 4", "date": "May, 28, 2019", "price": 18.99},
    {"title": "expense 5", "date": "June, 20, 2019", "price": 10.99},
    {"title": "expense 6", "date": "May, 18, 2019", "price": 12.99},
  ];

  deleteExpense(index) {
    setState(() {
      _expenses.removeAt(index);
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
            child: ListView.builder(
              itemCount: _expenses.length,
              itemBuilder: (context, index) => MySquare(
                title: _expenses[index]["title"] as String,
                date: _expenses[index]["date"] as String,
                price: _expenses[index]["price"] as double,
                deleteExpense: () => deleteExpense(index),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
