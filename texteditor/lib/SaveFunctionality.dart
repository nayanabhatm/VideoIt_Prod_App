import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

import 'dart:async';
import 'dart:io';

class SaveOption {
    String filenameEntered='';

   Future<dynamic> save(BuildContext context,String userEnteredData)
   {
    return Alert(
        context: context,
        title: 'Save As',
        style: AlertStyle(
            animationType: AnimationType.fromTop,
            animationDuration: Duration(seconds: 1),
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
              FileStorage(filenameEntered).saveFile(userEnteredData);
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

class FileStorage{
  String fileName;

  FileStorage(this.fileName);

  Future<String> get localPath async{
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get localFile async{
    final path=await localPath;
    print(fileName);
    print("----");
    print('$path/$fileName');
    return File('$path/$fileName');
  }

  Future<File> saveFile(String data) async{
    print(data);
    print("----");
    final file=await localFile;
    return file.writeAsString(data);
  }

  Future<String> readContent() async {
    try {
      final file = await localFile;
      String fileContents = await file.readAsString();
      // Returning the contents of the file
      return fileContents;
    } catch (e) {
      // If encountering an error, return
      return 'Error!';
    }
  }

}
