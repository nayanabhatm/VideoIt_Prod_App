import 'package:flutter/foundation.dart';
import 'package:whatsappstatus/models/saveImageOrVideo.dart';
import 'image.dart';
import 'video.dart';
import 'dart:io';
import 'package:whatsappstatus/models/sort.dart';
import 'package:whatsappstatus/models/shareImageOrVideo.dart';

class StatusViewModel extends ChangeNotifier{
  final Directory whatsAppStatusDirectory = Directory('/storage/emulated/0/WhatsApp/Media/.Statuses');
  bool _isSelectionMode = false;
  bool _selectAll=false;
  List<ImageFile> _imageFilesList=[];
  //List<VideoFile> _videoFilesList=[];

  int get imageFilesCount => _imageFilesList.length;
  bool get selectAll => _selectAll;

  int get countSelected{
     int cnt=0;
    _imageFilesList.forEach((element) {
      if(element.isSelected){
        cnt++;
      }
    });
    return cnt;
  }

  void shareMultipleImageFiles(){
    List<String> listOfImagesToShare=[];
    _imageFilesList.forEach((element) {
      if(element.isSelected)
        listOfImagesToShare.add(element.imagePath);
    });

    ShareImageVideo().shareImageVideoMultiple(listOfImagesToShare,'image');
  }

  Future<void> saveMultipleImageFiles() async{
    for(int i =0 ;i < _imageFilesList.length ; i++){
      var element = _imageFilesList[i] ;
      if(element.isSelected)
      {
        await SaveImageVideo.saveImage(element.imagePath);
      }
    }
  }

  List<ImageFile> get imageFiles => _imageFilesList;

  void toggleSelectAll(){
    _selectAll=!_selectAll;
    notifyListeners();
  }

  void makeSelectAllFalse(){
    _selectAll=false;
    notifyListeners();
  }

  void toggleSelected(int index){
    ImageFile image=_imageFilesList[index];
    image.toggleSelected();
    notifyListeners();
  }

  void makeSelectedFalse(){
    _imageFilesList.forEach((element) {
      element.makeSelectedFalse();
    });
    notifyListeners();
  }

  void makeSelectionModeFalse(){
    _isSelectionMode=false;
    notifyListeners();
  }

  void makeSelectedTrue(){
    _imageFilesList.forEach((element) {
      element.makeSelectedTrue();
    });
    notifyListeners();
  }

  void clearImageFilesList(){
    _imageFilesList.clear();
    notifyListeners();
  }

  void toggleSelectionMode(){
    _isSelectionMode=!_isSelectionMode;
    notifyListeners();
  }

  bool get isSelectionMode => _isSelectionMode;

  void addImagesToImagesList() async {
    List<FileSystemEntity> imagesFromDirectoryList=[];
    List<String> filePathList=[];
    imagesFromDirectoryList=await whatsAppStatusDirectory.list().where((event) => (!event.path.contains('.nomedia') && !event.path.contains('.mp4'))).toList();

    filePathList=await Sort(fileNamesList: imagesFromDirectoryList).sortFilesOnLastModifiedDate();

    filePathList.forEach((element) {
      _imageFilesList.add(ImageFile(imagePath:element));
    });
    notifyListeners();
  }



//  int get videoFilesCount => _videoFilesList.length;
//
//  List<VideoFile> get videoFiles => _videoFilesList;
//
//  void addNewVideoFile(String filePath){
//    _videoFilesList.add(VideoFile(videoPath:filePath));
//    notifyListeners();
//  }
//
//  void clearVideoFilesList(){
//    _imageFilesList.clear();
//    notifyListeners();
//  }

}