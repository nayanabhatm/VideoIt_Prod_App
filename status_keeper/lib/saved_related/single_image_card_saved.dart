import 'package:flutter/material.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:statuskeeper/models/image.dart';
import 'package:statuskeeper/models/status_view_model.dart';

class ImageCardSaved extends StatelessWidget {

  final ImageFile imageFile;
  ImageCardSaved({this.imageFile});

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
              //color: imageFile.isSelected ? Colors.transparent.withOpacity(0) : Colors.transparent.withOpacity(0),
            ),

            viewModelImagesData.isSelectionModeSavedImagesTab ?
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
