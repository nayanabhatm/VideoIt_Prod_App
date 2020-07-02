import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:async';
import 'FileStorage.dart';


class SaveOption {
    String filenameEntered='';

   Future<bool> save(BuildContext context,String userEnteredData)
   {
    return Alert(
        context: context,
        title: 'Save As',
        style: AlertStyle(
            animationType: AnimationType.fromTop,
            animationDuration: Duration(milliseconds: 500),
            titleStyle: TextStyle(
              color: Colors.white
            ),

        ),
        content: Column(
          children: [
            TextField(
              onChanged: (value){
                filenameEntered=value;
              },
              decoration: InputDecoration(
                  labelText: 'Filename',
                focusColor: Colors.white
              ),
            ),
          ],
        ) ,
        buttons: [
          DialogButton(
            color: Colors.teal,
            onPressed: () {
              FileStorage().saveFile(userEnteredData,filenameEntered);
              Navigator.pop(context);
            },
            child: Text(
              "Save",
              style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold),
            ),
          ),
          DialogButton(
            color: Colors.teal,
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Cancel",
              style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold),
            ),
          )
        ]
    ).show();
  }

}

