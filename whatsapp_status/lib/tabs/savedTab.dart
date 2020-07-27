import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:video_thumbnail/video_thumbnail.dart';
import '../models/displayImageScreen.dart';

class SavedTab extends StatefulWidget {
  @override
  _SavedTabState createState() => _SavedTabState();
}

class _SavedTabState extends State<SavedTab> {
  final Directory savedDirectory=Directory('/storage/emulated/0/Status Saver');
  List<Image> imageList=[];
  List<Uint8List> videoThumbnailsList=[];
  List<FileSystemEntity> listOfImageFilesInSavedDirectory=[];
  List<FileSystemEntity> listOfVideoFilesInSavedDirectory=[];

  void readImagesFromSavedDirectory() async{
    listOfImageFilesInSavedDirectory=await savedDirectory.list().where((event) => !event.path.contains('.mp4')).toList();

    print("...$listOfImageFilesInSavedDirectory...");


    for(var i=0;i<listOfImageFilesInSavedDirectory.length;i++){
      imageList.add(Image.file(File(listOfImageFilesInSavedDirectory[i].path),fit: BoxFit.cover,));
    }
  }

  void readVideosFromSavedDirectory() async{
    listOfVideoFilesInSavedDirectory=await savedDirectory.list().where((event) => !event.path.contains('.jpg')).toList();

    print("....$listOfVideoFilesInSavedDirectory");

    for(var i=0;i<listOfVideoFilesInSavedDirectory.length;i++){
      videoThumbnailsList.add(await VideoThumbnail.thumbnailData(
        video: listOfVideoFilesInSavedDirectory[i].path,
        imageFormat: ImageFormat.PNG,
        quality: 100,
      ));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readVideosFromSavedDirectory();
    readImagesFromSavedDirectory();
    setState(() {
      
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
    );
  }

}

