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
  final titleController = TextEditingController();
  final priceController = TextEditingController();
  final dateController = TextEditingController();
  String? errorTitleText;
  String? errorPriceText;

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
              TextField(
                decoration: InputDecoration(
                  labelText: "Expense Name",
                  errorText: errorTitleText,
                ),
                controller: titleController,
              ),
              // TextField(
              //   decoration: InputDecoration(labelText: "Expense Date"),
              //   keyboardType: TextInputType.datetime,
              //   controller: dateController,
              // ),
              TextField(
                decoration: InputDecoration(
                  labelText: "Amount Spent",
                  errorText: errorPriceText,
                ),
                keyboardType: TextInputType.number,
                controller: priceController,
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
                      errorTitleText = titleController.text.isEmpty
                          ? "Title must have a value"
                          : null;

                      errorPriceText = priceController.text.isEmpty
                          ? "You must enter a value"
                          : null;

                      if (titleController.text.isNotEmpty &&
                          priceController.text.isNotEmpty) {
                        Navigator.of(context).pop();
                        
                        setState(() {
                          userTransactions.add(
                            Transaction(
                              id: (userTransactions.length + 1),
                              title: titleController.text,
                              price: double.parse(priceController.text),
                              date: DateTime.now(),
                            ),
                          );
                        });

                        titleController.text = "";
                        priceController.text = "";
                      }
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

  void deleteExpense(index) {
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
              deleteExpense: deleteExpense,
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
