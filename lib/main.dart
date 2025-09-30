import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

import './models/transaction_model.dart';
import './widgets/transaction_list.dart';
import './widgets/new_transaction_form.dart';
import './widgets/chart.dart';

void main() {
  // To prevent rotating;
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(MyApp());
}

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

  bool _showChart = false;

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

  void addTransaction(title, price, date) {
    setState(() {
      userTransactions.add(
        Transaction(
          id: userTransactions.length + 1,
          title: title,
          price: double.parse(price),
          date: date,
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
    final mediaQuery = MediaQuery.of(context);
    final isLandscape =
        mediaQuery.orientation == Orientation.landscape;

    final appBar = AppBar(
      title: Text(
        "Personal Expenses",
        style: TextStyle(color: Colors.white, fontSize: 24),
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
    );

    final transactionListWidget = Expanded(
      child: TransactionList(
        userTransactions: userTransactions,
        deleteExpense: deleteTransaction,
      ),
    );

    return Scaffold(
      appBar: appBar,

      body: Column(
        children: [
          // Switch in landscape;
          if (isLandscape)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _showChart == false ? "Show Chart" : "Show Transactions",
                  style: TextStyle(fontSize: 18),
                ),
                Switch(
                  value: _showChart,
                  onChanged: (value) {
                    setState(() {
                      _showChart = value;
                    });
                  },
                ),
              ],
            ),

          // Chart in portrait
          if (!isLandscape) // Chart View
            Container(
              height:
                  (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.25,
              margin: EdgeInsets.symmetric(vertical: 5),
              child: Chart(recentTransactions: _recentTransactions),
            ),

          // Transaction List in portrait
          if (!isLandscape) transactionListWidget,

          // Either or case in Landscape
          if (isLandscape)
            _showChart == true
                ?
                  // Chart View
                  Container(
                    height:
                        (mediaQuery.size.height -
                            appBar.preferredSize.height -
                            mediaQuery.padding.top) *
                        0.7,
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: Chart(recentTransactions: _recentTransactions),
                  )
                :
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
