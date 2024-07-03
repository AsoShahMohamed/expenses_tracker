import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './adaptive_button.dart';

class AddingTransaction extends StatefulWidget {
  // const MyWidget({super.key});

  final Function _addTransaction;
  final BuildContext _bContext;

  AddingTransaction(this._addTransaction, this._bContext) ;

  @override
  State<AddingTransaction> createState() {


    return _AddingTransactionState();
  }
}

class _AddingTransactionState extends State<AddingTransaction> {
 


  // @override
  // void didUpdateWidget(covariant AddingTransaction oldWidget) {
  //   print('at state didupdatewidget');
  //   super.didUpdateWidget(oldWidget);
  // }

  final inputAmountController = TextEditingController();

  final inputTitleController = TextEditingController();

  var _selectedDate;

  void checkToAdd() {
    //doesnt check for being a number

    if (inputAmountController.text.isEmpty) {
      return;
    }

    final amount = double.parse(inputAmountController.text);

    final title = inputTitleController.text;

    if (title.isEmpty || amount < 0 || _selectedDate == null) {
      return;
    }

    widget._addTransaction(title, amount, _selectedDate);

    Navigator.of(context).pop();
  }

  void _displayDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2024),
    ).then((DateTime) {
      if (DateTime == null) {
        return;
      }

      setState(() {
        _selectedDate = DateTime;
      });
    }, onError: (error) {
      throw error;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 20,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              right: 10,
              left: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: inputTitleController,
                // onChanged: (input) => titleinput = input,
                autocorrect: false,
                autofocus: true,
                cursorColor: Colors.pink,
                cursorWidth: 3.0,
                decoration: InputDecoration(labelText: 'Title'),
                readOnly: false,
                onSubmitted: (_) => checkToAdd(),
              ),
              TextField(
                controller: inputAmountController,
                // onChanged: (input) => amountInput = input,
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                onSubmitted: (_) => checkToAdd(),
              ),
              Container(
                height: 75,
                child: Row(children: <Widget>[
                  Expanded(
                    child: Text(
                      _selectedDate != null
                          ? 'picked date: \t ${DateFormat.yMd().format(_selectedDate)}'
                          : 'no date chosen!',
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0, backgroundColor: Colors.white),
                      onPressed: _displayDatePicker,
                      child: Text(
                        'click to pick!!',
                        style: Theme.of(context).textTheme.button,
                      )),
                ]),
              ),
              AdaptiveButton(checkToAdd),
            ],
          ),
        ),
      ),
    );
  }
}
