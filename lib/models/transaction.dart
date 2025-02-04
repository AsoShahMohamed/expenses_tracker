// import 'package:flutter/foundation.dart';

class Transaction {
  final String id;
  final double amount;
  final DateTime datetime;
  final String title;

  Transaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.datetime,
  });
}
