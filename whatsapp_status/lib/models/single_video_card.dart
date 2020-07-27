import 'package:flutter/material.dart';
import 'dart:io';

class VideoCard extends StatelessWidget {

  final String videoPath;
  final bool isSelected;

  VideoCard({this.videoPath,this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      child:  Card(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.file(
              File(videoPath),
              fit: BoxFit.cover,
              colorBlendMode: BlendMode.color,
              color: Colors.black.withOpacity(isSelected? 0.9 : 0 ),
            ),
            isSelected ?Align(
              alignment: Alignment.bottomRight,
              child: Icon(
                Icons.check_box,
                size: 34.0,
                color: Colors.lightGreen,
              ),
            ):
            Container()
          ],
        ),
        elevation: 20.0,
      ),
    );
  }
}
