import 'package:flutter/cupertino.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/material.dart';
import 'SaveFunctionality.dart';

class NewOption{
    String filenameEntered='';
    Future<dynamic> new1(BuildContext context,String currentTextData){
      if(currentTextData!=null)
      {
      return Alert(
          context: context,
          title: 'Save Current File?',
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
                SaveOption saveOption=await SaveOption();
                await saveOption.save(context,currentTextData);
                Navigator.pop(context);
              },
              child: Text(
                "Save",
                style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.normal),
              ),
            ),
            DialogButton(
              color: Colors.teal,
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Discard",
                style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.normal),
              ),
            )
          ]
      ).show();
      }
    }
}