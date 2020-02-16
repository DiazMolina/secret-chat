import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Dialogs {
  static void alert(BuildContext context,
      {String title = '', String message = ''}) {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            content: Text(
              message,
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 14),
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }
  static void confirm(BuildContext context,
      {String title = '', String message = '',VoidCallback onCancel,VoidCallback onConfirm}) {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            content: Text(
              message,
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 14),
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text('Cancel',style: TextStyle(color: Colors.redAccent),),
                onPressed: onCancel,
              ),
              CupertinoDialogAction(
                child: Text('OK'),
                onPressed: onConfirm
              )
            ],
          );
        });
  }
}
