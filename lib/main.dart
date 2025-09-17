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
class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<Map<String, Object>> _expenses = [
    {"title": "expense 1", "date": "May, 28, 2019", "price": 17.99},
    {"title": "expense 2", "date": "July, 30, 2019", "price": 9.99},
    {"title": "expense 3", "date": "Apr, 15, 2019", "price": 25.99},
    {"title": "expense 4", "date": "May, 28, 2019", "price": 18.99},
    {"title": "expense 5", "date": "June, 20, 2019", "price": 10.99},
    {"title": "expense 6", "date": "May, 18, 2019", "price": 12.99},
  ];

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
          SizedBox(height: 200, child: BarChart(BarChartData())),

          // Expense List View
          Expanded(
            child: ListView(
              children: [
                MySquare(
                  title: _expenses[0]["title"] as String,
                  date: _expenses[0]["date"] as String,
                  price: _expenses[0]["price"] as double,
                ),
                MySquare(
                  title: _expenses[1]["title"] as String,
                  date: _expenses[1]["date"] as String,
                  price: _expenses[1]["price"] as double,
                ),
                MySquare(
                  title: _expenses[2]["title"] as String,
                  date: _expenses[2]["date"] as String,
                  price: _expenses[2]["price"] as double,
                ),
                MySquare(
                  title: _expenses[3]["title"] as String,
                  date: _expenses[3]["date"] as String,
                  price: _expenses[3]["price"] as double,
                ),
                MySquare(
                  title: _expenses[4]["title"] as String,
                  date: _expenses[4]["date"] as String,
                  price: _expenses[4]["price"] as double,
                ),
                MySquare(
                  title: _expenses[5]["title"] as String,
                  date: _expenses[5]["date"] as String,
                  price: _expenses[5]["price"] as double,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
