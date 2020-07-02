import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:io';

class CloseOption {

  Future<bool> close(BuildContext context) {
    return Alert(
        context: context,
        title: 'Do You Want to Exit?',
        style: AlertStyle(
          animationType: AnimationType.fromBottom,
          animationDuration: Duration(milliseconds: 500),
          titleStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.normal,
          ),

        ),
        buttons: [
          DialogButton(
            color: Colors.teal,
            onPressed: () async {
              exit(0);
            },
            child: Text(
              "Yes",
              style: TextStyle(color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.normal),
            ),
          ),
          DialogButton(
            color: Colors.teal,
            onPressed: () => Navigator.pop(context),
            child: Text(
              "No",
              style: TextStyle(color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.normal),
            ),
          )
        ]
    ).show();
  }
}