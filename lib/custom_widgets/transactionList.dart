import 'package:flutter/material.dart';

import '../models/transaction.dart';
import './ListTransactionItem.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> tList;
  final Function deleteTx;

  const TransactionList(this.tList, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    // print('build called at transactionlist');
    return tList.isEmpty
        ? LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    height: constraints.maxHeight * 0.1,
                    margin: EdgeInsets.only(top: 5),
                    alignment: Alignment.center,
                    child: Text(
                      'currently Empty !!',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  Container(
                    height: constraints.maxHeight * 0.7,
                    child: Image.asset(
                      'assets/images/Method Draw Image.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              );
            },
          )
        : ListView(
            children: tList.map((tx) {
              return ListTransactionItem(
                  tx: tx, deleteTx: deleteTx, key: ValueKey(tx.id));
            }).toList(),
            scrollDirection: Axis.vertical,
          );
  }
}
