import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './transactionList.dart';
import './adding_new_transactions.dart';
import '../models/transaction.dart';

class UserTransaction extends StatefulWidget {
  @override
  State<UserTransaction> createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
  final List<Transaction> _tList = [
    Transaction(
      id: 'abc1',
      amount: 99.99,
      datetime: DateTime.now(),
      title: 'abcdefg',
    ),
    Transaction(
        id: 'abc2',
        amount: 8.99,
        datetime: DateTime.now(),
        title: 'ddaasdsada'),
  ];

  void _addTransaction(String title, double amount) {
    // final
    final newTX = Transaction(
      title: title,
      amount: amount,
      id: DateTime.now().toString(),
      datetime: DateTime.now(),
    );

    setState(() {
      _tList.add(newTX);
    });
  }

  @override
  Widget build(BuildContext context) {
   
    return Column(children: <Widget>[
      AddingTransaction(_addTransaction),
      TransactionList(_tList),
    ]);
   
   
  }
}
