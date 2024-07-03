import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './custom_widgets/transactionList.dart';
import './models/transaction.dart';
import './custom_widgets/adding_new_transactions.dart';
import './custom_widgets/chart.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitDown, DeviceOrientation.portraitDown]);

  runApp(SinglePageApplicationRootWidget());
}

// Platform.isIOS
//         ? CupertinoApp(
//             title: 'cupertino exptms',
//             home: singlePageAncestorWidget(),
//             theme: CupertinoThemeData(
//                 // textTheme:CupertinoThemeData().textTheme,
//                 primaryColor: Colors.purple,
//                 primaryContrastingColor: Colors.white),
//           )

class SinglePageApplicationRootWidget extends StatelessWidget {
  Widget build(BuildContext buildContext) {
    return MaterialApp(
      theme: ThemeData(
          textTheme: ThemeData.light().textTheme.copyWith(
              headline3: const TextStyle(
                fontFamily: 'BRICK',
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
              button: const TextStyle(color: Colors.red)),
          appBarTheme: const AppBarTheme(
            // textTheme:ThemeData.light().textTheme.copyWith(title:TextStyle(fontFamily: 'Rubik',fontSize: 25)),
            titleTextStyle: TextStyle(
                fontFamily: 'BRICK', fontSize: 15, fontWeight: FontWeight.bold),
          ),
          fontFamily: 'Rubik',
          // appBarTheme: AppBarTheme(),
          primarySwatch: Platform.isIOS ? Colors.purple : Colors.red,
          accentColor: Colors.blueAccent),
      title: 'regular string title for expense tracking system!!',
      home: singlePageAncestorWidget(),
    );
  }
}

class singlePageAncestorWidget extends StatefulWidget {
  @override
  State<singlePageAncestorWidget> createState() =>
      _SinglePageAncestorWidgetState();
}

class _SinglePageAncestorWidgetState extends State<singlePageAncestorWidget>
    with WidgetsBindingObserver {
  final List<Transaction> _tList = [
    // Transaction(
    //   id: 'abc1',
    //   amount: 99.99,
    //   datetime: DateTime.now(),
    //   title: 'abcdefg',
    // ),=
  ];

  bool isPIOS = Platform.isIOS;
  bool switchState = false;
  List<Transaction> get _recentTransactions {
    return _tList.where((tx) {
      return tx.datetime.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
  }
// @override
//   void didUpdateWidget(covariant singlePageAncestorWidget oldWidget) {
//    WidgetsBinding.instance.
//     super.didUpdateWidget(oldWidget);
//   }

  @override
  void dispose() async {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _addTransaction(String title, double amount, DateTime chosenDate) {
    // final
    final newTX = Transaction(
      title: title,
      amount: amount,
      id: DateTime.now().toString(),
      datetime: chosenDate,
    );

    setState(() {
      _tList.add(newTX);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _tList.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  void _startAddingNewTransaction(BuildContext bcntx) {
    showModalBottomSheet(
      context: bcntx,
      builder: (_) {
        return GestureDetector(
          child: AddingTransaction(_addTransaction, context),
          onTap: () {},
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  List<Widget> _buildLandScapeView(double availHeight) {
    return [
      Container(
        height: availHeight * 0.1,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('show chart??', style: Theme.of(context).textTheme.titleLarge),
          Switch.adaptive(
            activeColor: Theme.of(context).accentColor,
            value: switchState,
            onChanged: (state) {
              setState(() {
                switchState = state;
              });
            },
          ),
        ]),
      ),
      switchState
          ? Container(
              height: availHeight * 0.6, child: Chart(_recentTransactions))
          :

          // Chart(_recentTransactions),
          Container(
              height: availHeight * 0.6,
              child: TransactionList(_tList, _deleteTransaction))
    ];
  }

  List<Widget> buildPortraitView(double availHeight) {
    return [
      Container(height: availHeight * 0.3, child: Chart(_recentTransactions)),
      Container(
          height: availHeight * 0.7,
          child: TransactionList(_tList, _deleteTransaction)),
    ];
  }

  // late String titleinput;
  @override
  Widget build(BuildContext buildContext) {
    // print('build called at singlePageAncestorWidget');
    final MediaQueryData mqd = MediaQuery.of(context);
    final isLandScape = mqd.orientation == Orientation.landscape;

    final appbar;

    if (isPIOS) {
      appbar = CupertinoNavigationBar(
        middle: const Text('this si then cupertino!'),
        trailing: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
          GestureDetector(
              child: const Icon(CupertinoIcons.add),
              onTap: () => _startAddingNewTransaction(buildContext)),
        ]),
      );
    } else {
      appbar = AppBar(
        title: Text('ExpsTMS'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddingNewTransaction(buildContext),
          )
        ],
      );
    }

    final double availHeight =
        mqd.size.height - appbar.preferredSize.height - mqd.padding.top;

    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            if (isLandScape) ..._buildLandScapeView(availHeight),
            if (!isLandScape) ...buildPortraitView(availHeight),
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(child: pageBody, navigationBar: appbar)
        : Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.startDocked,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    onPressed: () => _startAddingNewTransaction(buildContext),
                    child: Icon(Icons.add),
                  ),
            appBar: appbar,
            body: pageBody,
          );
  }
}
