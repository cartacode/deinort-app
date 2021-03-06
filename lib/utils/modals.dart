import 'package:flutter/material.dart';

void showAlertDialog(context, text) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Alert Dialog title"),
          content: new Text("Alert Dialog body"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showAlert(BuildContext context, errMsg) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text("$errMsg"),
      ));
  }