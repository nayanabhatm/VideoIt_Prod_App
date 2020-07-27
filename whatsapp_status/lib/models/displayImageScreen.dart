import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'saveImageOrVideo.dart';
import '../constants.dart';
import 'shareImageOrVideo.dart';

class DisplayImage extends StatefulWidget {
  final int index;
  final String imageFilePath;

  DisplayImage({this.index,this.imageFilePath});

  @override
  _DisplayImageState createState() => _DisplayImageState();
}


class _DisplayImageState extends State<DisplayImage> {
  SaveImageVideo saveImageVideo=SaveImageVideo();
  ShareImageVideo shareImageVideo=ShareImageVideo();

  @override
  Widget build(BuildContext context) {
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
                SaveImageVideo.saveImage(widget.imageFilePath);
                Scaffold.of(context).showSnackBar(kSnackBarForImageSave);
              },
            ),
          ),
          IconButton(
            tooltip: "Share",
            icon: Icon(Icons.share),
            onPressed: (){
              shareImageVideo.shareImageVideo(widget.imageFilePath,'image');
            },
          ),
          IconButton(
            tooltip: "Repost",
            icon: Icon(Icons.repeat),
            onPressed: (){

            },
          ),
          SizedBox(width: 10.0,)
        ],
      ),
      body: Center(
        child: Hero(
          tag: 'index${widget.index}',
          child: Container(
            child: Image.file(
             File(widget.imageFilePath),
             fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}


