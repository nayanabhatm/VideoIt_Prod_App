import 'package:flutter/material.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:whatsappstatus/data/image.dart';
import 'package:whatsappstatus/data/status_view_model.dart';

class ImageCard extends StatelessWidget {

  final ImageFile imageFile;
  ImageCard({this.imageFile});

  @override
  Widget build(BuildContext context) {
    var viewModelImagesData=Provider.of<StatusViewModel>(context);
    return Container(
      child:  Card(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.file(
              File(imageFile.imagePath),
              fit: BoxFit.cover,
              //color: Colors.black.withOpacity(imageFile.isSelected? 0.9:0 ),
            ),

            viewModelImagesData.isSelectionMode ?
             Align(
              alignment: Alignment.bottomRight,
              child: Icon(
                imageFile.isSelected ? Icons.check_box : Icons.check_box_outline_blank,
                size: 30.0,
                color: Colors.lightGreen,
              ),
            ) :  Container()
          ],
        ),
        elevation: 20.0,
      ),
    );
  }
}
