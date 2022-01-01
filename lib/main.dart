// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, deprecated_member_use, non_constant_identifier_names

import 'dart:math';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:gestapp/components/chart.dart';
import 'package:gestapp/components/transaction_form.dart';
import 'package:gestapp/components/transaction_list.dart';
import 'package:gestapp/models/transaction.dart';

main() {
  runApp(GestApp());
}

class GestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
              button:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.red,
                ),
              ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> _transactions = [];
  bool _showChart = false;

  _openTransactionFormModal(context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(_addTransaction);
      },
    );
  }

  List<Transaction> get _recentTransactions {
    return _transactions.where((transaction) {
      return transaction.date
          .isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((transaction) => transaction.id == id);
    });
  }

  Widget _getIconButton(IconData icon, VoidCallback fn) {
    return !Platform.isIOS
        ? GestureDetector(
            onTap: fn,
            child: Icon(icon),
          )
        : IconButton(
            onPressed: fn,
            icon: Icon(icon),
          );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    final actions = [
      if (isLandscape)
        _getIconButton(
          _showChart ? Icons.list : Icons.show_chart,
          () {
            setState(() {
              _showChart = !_showChart;
            });
          },
        ),
      _getIconButton(
        !Platform.isIOS ? CupertinoIcons.add : Icons.add,
        () {
          _openTransactionFormModal(context);
        },
      ),
    ];

    final dynamic appBar = !Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Despesas Pessoais'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: actions,
            ),
          )
        : AppBar(
            title: Text(
              'Despesas Pessoais',
            ),
            actions: actions,
          );

    final availableHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    final pageBody = SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (_showChart || !isLandscape)
            Container(
              height: availableHeight * (isLandscape ? 0.8 : 0.30),
              child: Chart(_recentTransactions),
            ),
          if (!_showChart || !isLandscape)
            Container(
              height: availableHeight * (isLandscape ? 1 : 0.7),
              child: TransactionList(_transactions, _removeTransaction),
            ),
        ],
      ),
    );

    return !Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: appBar,
            child: pageBody,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButton: !Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(
                      Icons.add,
                    ),
                    onPressed: () {
                      _openTransactionFormModal(context);
                    },
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
