import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:statuskeeper/functionalities/saveImageOrVideo.dart';
import 'package:statuskeeper/constants.dart';
import 'package:statuskeeper/functionalities/shareImageOrVideo.dart';
import 'package:statuskeeper/models/status_view_model.dart';

class DisplayImage extends StatelessWidget{
  final int index;
  final String imageFilePath;

  DisplayImage({this.index,this.imageFilePath});

  @override
  Widget build(BuildContext context) {
    var viewModelData=Provider.of<StatusViewModel>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Images"),
        backgroundColor: Colors.black,
        actions: <Widget>[
          Builder(
            builder: (context)=>
            IconButton(
              tooltip: "Save",
              icon: Icon(Icons.save),
              onPressed: (){
                viewModelData.saveSingleFile(imageFilePath,'images');
                Scaffold.of(context).showSnackBar(kSnackBarForSaved);
              },
            ),
          ),
          IconButton(
            tooltip: "Share",
            icon: Icon(Icons.share),
            onPressed: (){
              ShareImageVideo.shareImageVideo(imageFilePath,'image');
            },
          ),
          SizedBox(width: 15.0,)
        ],
      ),
      body: Center(
        child: Hero(
          tag: 'index$index',
          child: Container(
            child: Image.file(
             File(imageFilePath),
             fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}


