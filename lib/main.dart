import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
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
    return Platform.isIOS
        ? CupertinoApp(
            title: "Expense Tracker",
            home: HomePage(),
            theme: CupertinoThemeData(
              brightness: Brightness.light,
              primaryColor: CupertinoColors.systemPurple,
              primaryContrastingColor: CupertinoColors.white,
              textTheme: CupertinoTextThemeData(
                textStyle: TextStyle(fontSize: 16),
                navTitleTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
          )
        : MaterialApp(
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

  List<Widget> _buildLandscapeContent(
    MediaQueryData mediaQuery,
    AppBar appBar,
    Widget transactionListWidget,
  ) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _showChart == false ? "Show Chart" : "Show Transactions",
            style: TextStyle(fontSize: 18),
          ),
          Switch.adaptive(
            value: _showChart,
            onChanged: (value) {
              setState(() {
                _showChart = value;
              });
            },
          ),
        ],
      ),
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
            transactionListWidget,
    ];
  }

  List<Widget> _buildPortraitContent(
    MediaQueryData mediaQuery,
    AppBar appBar,
    Widget transactionListWidget,
  ) {
    return [
      Container(
        height:
            (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.25,
        margin: EdgeInsets.symmetric(vertical: 5),
        child: Chart(recentTransactions: _recentTransactions),
      ),
      transactionListWidget,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final isIOS = Platform.isIOS;
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    final PreferredSizeWidget appBar = isIOS
        ? CupertinoNavigationBar(
            middle: Text("Personal Expense Tracker"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: _startAddExpense,
                  icon: Icon(CupertinoIcons.add),
                ),
              ],
            ),
          )
        : AppBar(
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

    final pageBody = SafeArea(
      // Safe Area excludes nav bar size in the overall page height;
      child: Column(
        children: [
          // Switch in landscape;
          if (isLandscape)
            ..._buildLandscapeContent(
              mediaQuery,
              appBar as AppBar,
              transactionListWidget,
            ),

          // Chart in portrait
          if (!isLandscape)
            ..._buildPortraitContent(
              mediaQuery,
              appBar as AppBar,
              transactionListWidget,
            ),
        ],
      ),
    );

    return isIOS
        ? CupertinoPageScaffold(
            navigationBar: appBar as ObstructingPreferredSizeWidget,
            child: pageBody,
          )
        : Scaffold(
            appBar: appBar,

            body: pageBody,

            floatingActionButton: isIOS
                ? Container()
                : FloatingActionButton(
                    onPressed: _startAddExpense,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: Icon(Icons.add),
                  ),
          );
  }
}
