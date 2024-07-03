import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveButton extends StatelessWidget {
  final  Function _checkToAdd;

  AdaptiveButton(this._checkToAdd);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            onPressed: ()=>_checkToAdd(),
            child: Text('IOS submission'),
          )
        : ElevatedButton(
            onPressed:()=> _checkToAdd(),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.blue,
              backgroundColor: Colors.white,
            ),
            child: Text('android submission'),
          );
  }
}
