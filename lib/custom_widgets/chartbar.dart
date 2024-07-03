import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  @override
  final String weekLabel;
  final double amount;
  final double amountPercentage;

  ChartBar(this.weekLabel, this.amount, this.amountPercentage);

  Widget build(BuildContext context) {
  //  print('build called at chartbar');
    return LayoutBuilder(
      builder: (cntx, constraints) {
        return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(height: constraints.maxHeight * 0.2,
                child: FittedBox(
                  child: Text(
                      
                    weekLabel,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
              ),
              SizedBox(
                height: constraints.maxHeight * 0.05,
              ),
              Container(
                width: 10,
                height: constraints.maxHeight * 0.6,
                child: Stack(children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(100, 100, 100, 0.4),
                        border: Border.all(
                            color: Color.fromRGBO(150, 150, 150, 0.6),
                            width: 2),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  FractionallySizedBox(
                    heightFactor: amountPercentage,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ]),
              ),
              SizedBox(
                height: constraints.maxHeight * 0.05,
              ),
              Container(
                  height: constraints.maxHeight * 0.1,
                  child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text('\$${amount.toStringAsFixed(0)}',
                          style: Theme.of(context).textTheme.headline6))),
            ]);
      },
    );
  }
}
