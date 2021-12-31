// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:gestapp/components/transaction_form.dart';
import 'package:gestapp/components/transaction_list.dart';
import 'package:gestapp/models/transaction.dart';

class TransactionUser extends StatefulWidget {
  @override
  _TransactionUserState createState() => _TransactionUserState();
}

class _TransactionUserState extends State<TransactionUser> {
  final _transactions = [
    Transaction(
      id: 't1',
      title: 'Novo Tênis de Corrida',
      value: 310.76,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Conta de Luz',
      value: 211.30,
      date: DateTime.now(),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TransactionList(_transactions),
        TransactionForm(),
      ],
    );
  }
}
