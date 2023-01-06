import 'dart:io';

import 'package:expenses_app/widgets/chart.dart';
import 'package:expenses_app/widgets/new_transactions.dart';
import 'package:expenses_app/widgets/transaction_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'models/transaction.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.deepOrange,
          accentColor: Colors.amber,
        ),
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              titleMedium: const TextStyle(
                fontFamily: 'Open Sans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
              fontFamily: 'Open Sans',
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransaction = [
    // Transaction(
    //   id: 't1',
    //   title: "New Shoes",
    //   amount: 1200,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: "Groceries",
    //   amount: 2500,
    //   date: DateTime.now(),
    // ),
  ];

  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _userTransaction.where((transaction) {
      return transaction.date
          .isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime chosenDate) {
    final newTransaction = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: chosenDate,
    );
    setState(() {
      _userTransaction.add(newTransaction);
    });
  }

  void _deleteTransactions(String id) {
    setState(() {
      _userTransaction.removeWhere((transaction) => transaction.id == id);
    });
  }

  void showAddTransactionSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return NewTransaction(addTransactionHandler: _addNewTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandScape = mediaQuery.orientation == Orientation.landscape;

    final appBar = AppBar(
      title: const Text("Personal Expenses"),
      actions: [
        IconButton(
          onPressed: () => showAddTransactionSheet(context),
          icon: const Icon(Icons.add),
        ),
      ],
    );

    final navigationBar = CupertinoNavigationBar(
      middle: const Text("Personal Expenses"),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () => showAddTransactionSheet(context),
            child: const Icon(CupertinoIcons.add),
          )
        ],
      ),
    );

    final appBarHeight = Platform.isIOS
        ? navigationBar.preferredSize.height
        : appBar.preferredSize.height;

    final transactionListWidget = SizedBox(
      height: (mediaQuery.size.height - appBarHeight - mediaQuery.padding.top) *
          0.7,
      child: TransactionList(
        _userTransaction,
        _deleteTransactions,
      ),
    );

    SizedBox chartWidget(BuildContext context, double screenRatio) {
      return SizedBox(
        height:
            (mediaQuery.size.height - appBarHeight - mediaQuery.padding.top) *
                screenRatio,
        child: Chart(recentTransactions: _recentTransactions),
      );
    }

    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isLandScape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Show Chart",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Switch.adaptive(
                      activeColor: Theme.of(context).colorScheme.secondary,
                      value: _showChart,
                      onChanged: (value) {
                        setState(() {
                          _showChart = value;
                        });
                      }),
                ],
              ),
            if (!isLandScape) chartWidget(context, 0.3),
            if (!isLandScape) transactionListWidget,
            if (isLandScape)
              _showChart ? chartWidget(context, 0.7) : transactionListWidget,
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: navigationBar,
            child: pageBody,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    onPressed: () => showAddTransactionSheet(context),
                    child: const Icon(Icons.add),
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
