import '../models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './chartbar.dart';

class Chart extends StatelessWidget {
  List<Transaction> tList;

  Chart(this.tList);

  List<Map<String, Object>> get _groupedTransactions {
  return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      double tAmount = 0.0;

      for (int i = 0; i < tList.length; i++) {
        if (tList[i].datetime.year == weekDay.year &&
            tList[i].datetime.month == weekDay.month &&
            tList[i].datetime.day == weekDay.day) {
          tAmount += tList[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': tAmount,
      };
    }).reversed.toList();

   
  }

  double get _totalWeeklySpendings {
    return _groupedTransactions.fold(0.0, (sum, tx) {
      return sum + (tx['amount'] as double);
    });

  
  }

  @override
  Widget build(BuildContext context) {
      // print('build called at chart'); 
    return Card(
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _groupedTransactions.map((tx) {
          // return Text(' ${tx['day']}  \$${tx['amount']}');
      
          return Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: ChartBar(
              (tx['day'] as String),
              (tx['amount'] as double),
              _totalWeeklySpendings > 0.0 ? (tx['amount'] as double) / _totalWeeklySpendings : 0.0,
            ),
          );
        }).toList()),
      ),
      elevation: 10,
      margin: EdgeInsets.all(5),
    );
  }
}
