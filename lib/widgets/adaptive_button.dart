import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveButton extends StatelessWidget {
  final txt ;
  final action;
  AdaptiveButton(this.txt, this.action);
  
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(txt),
            onPressed: action,
          )
        : FlatButton(
            child: Text(txt),
            textColor: Colors.purple,
            onPressed: action,
          );
  }
}
