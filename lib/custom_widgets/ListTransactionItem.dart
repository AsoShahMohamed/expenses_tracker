import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class ListTransactionItem extends StatefulWidget {
 
  const ListTransactionItem({
    super.key,
    required this.tx,
    required this.deleteTx,
  });

  final Transaction tx;
  final Function deleteTx;

  @override
  State<ListTransactionItem> createState() => _ListTransactionItemState();
}

class _ListTransactionItemState extends State<ListTransactionItem> {
  late Color _bgColor;

  @override
  void initState() {
    const availColors = [Colors.red, Colors.blue, Colors.yellow];

    _bgColor = availColors[Random().nextInt(3)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: ListTile(
        leading: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: _bgColor,
            shape: BoxShape.circle,
          ),
          child: Padding(
            child: FittedBox(child: Text('\$${widget.tx.amount}')),
            padding: EdgeInsets.all(10),
          ),
        ),
        title: Text(
          '${widget.tx.title}',
          style: Theme.of(context).textTheme.headline3,
        ),
        subtitle: Text(DateFormat.yMMMd().format(widget.tx.datetime)),
        trailing: MediaQuery.of(context).size.width > 360
            ? ElevatedButton.icon(
                onPressed: () {
                  widget.deleteTx(widget.tx.id);
                },
                icon: Icon(Icons.delete),
                label: Text('delete me!'),
              )
            : IconButton(
                color: Theme.of(context).errorColor,
                icon: Icon(Icons.delete),
                onPressed: () {
                  widget.deleteTx(widget.tx.id);
                }),
      ),
    );
  }
}
