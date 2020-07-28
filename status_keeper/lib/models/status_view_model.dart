import 'package:flutter/foundation.dart';
import 'package:statuskeeper/functionalities/saveImageOrVideo.dart';
import 'package:statuskeeper/models/image.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:statuskeeper/functionalities/sort.dart';
import 'package:statuskeeper/functionalities/shareImageOrVideo.dart';
import 'package:statuskeeper/models/video.dart';
import 'package:video_thumbnail/video_thumbnail.dart';


class StatusViewModel extends ChangeNotifier{
  final Directory whatsAppStatusDirectory = Directory('/storage/emulated/0/WhatsApp/Media/.Statuses');
  final Directory savedFilesDirectory = Directory('/storage/emulated/0/Status Keeper');

  bool _isLongPress = false;
  bool _isSelectAll=false;

  List<bool> _savedTabToggleButtons=[true,false];
  List<ImageFile> _imageFilesWhatsappDir=[];
  List<VideoFile> _videoFilesWhatsappDir=[];
  List<ImageFile> _imageFilesSavedDir=[];
  List<VideoFile> _videoFilesSavedDir=[];

  void toggleSavedTabToggleButtons(int index){
    for (int i = 0; i < _savedTabToggleButtons.length; i++) {
      _savedTabToggleButtons[i] = i == index;
    }
    notifyListeners();
  }

  bool get savedTabToggleButtonImage => _savedTabToggleButtons[0];
  bool get savedTabToggleButtonVideo => _savedTabToggleButtons[1];
  List<bool> get savedTabToggleButtons => _savedTabToggleButtons;


  Future<Uint8List> getVideoThumbnailBytes(String path) async{
    Uint8List bytes=await VideoThumbnail.thumbnailData(
      video: path,
      imageFormat: ImageFormat.PNG,
      quality: 25,
    ) ;
    return bytes;
  }


  bool get isLongPress => _isLongPress;


  void makeSelectionModeLongPressFalse(){
    _isLongPress=false;
    notifyListeners();
  }

  void toggleisLongPress(){
    _isLongPress=!_isLongPress;
    notifyListeners();
  }


  bool get isSelectAll => _isSelectAll;
  void toggleIsSelectAll(){
    _isSelectAll=!_isSelectAll;
    notifyListeners();
  }
  void makeIsSelectAllFalse(){
    _isSelectAll=false;
    notifyListeners();
  }


  int get imageFilesWhatsappDirCount => _imageFilesWhatsappDir.length;
  int get videoFilesWhatsappDirCount => _videoFilesWhatsappDir.length;
  int get imageFilesSavedDirCount => _imageFilesSavedDir.length;
  int get videoFilesSavedDirCount => _videoFilesSavedDir.length;

  int countOfFilesSelected(String type){
      int cnt=0;
      if(type=='images')
      {
        _imageFilesWhatsappDir.forEach((element) {
          if(element.isSelected){
            cnt++;
          }
        });
      }
      else if(type=='videos')
      {
        _videoFilesWhatsappDir.forEach((element) {
          if(element.isSelected){
            cnt++;
          }
        });
      }
      else if(type=='savedImages')
      {
        _imageFilesSavedDir.forEach((element) {
          if(element.isSelected){
            cnt++;
          }
        });
      }
      else if(type=='savedVideos')
      {
        _videoFilesSavedDir.forEach((element) {
          if(element.isSelected){
            cnt++;
          }
        });
      }

      return cnt;
  }

  void shareMultipleFiles(String type){
    List<String> listOfAssetsToShare=[];
    if(type=='images')
    {
      _imageFilesWhatsappDir.forEach((element) {
        if(element.isSelected)
          listOfAssetsToShare.add(element.imagePath);
      });
      ShareImageVideo.shareImageVideoMultiple(listOfAssetsToShare,'image');

    }
    else if(type=='videos')
    {
      _videoFilesWhatsappDir.forEach((element) {
        if(element.isSelected)
          listOfAssetsToShare.add(element.videoPath);
      });

      ShareImageVideo.shareImageVideoMultiple(listOfAssetsToShare,'file');

    }
    else if(type=='savedImages')
    {
      _imageFilesSavedDir.forEach((element) {
        if(element.isSelected)
          listOfAssetsToShare.add(element.imagePath);
      });

      ShareImageVideo.shareImageVideoMultiple(listOfAssetsToShare,'image');

    }
    else if(type=='savedVideos')
    {
      _videoFilesSavedDir.forEach((element) {
        if(element.isSelected)
          listOfAssetsToShare.add(element.videoPath);
      });
      ShareImageVideo.shareImageVideoMultiple(listOfAssetsToShare,'file');
    }

  }

  Future<void> saveSingleFile(String path,String type) async{
    if(type=='images')
    {
      await SaveImageVideo.saveImage(path);
      makeIsSelectedFilesFalse('savedImages');
      clearFilesList('savedImages');
      addFilesToList('savedImages');
    }
    else if(type=='videos')
    {
      await SaveImageVideo.saveVideo(path);
      makeIsSelectedFilesFalse('savedVideos');
      clearFilesList('savedVideos');
      addFilesToList('savedVideos');
    }

    notifyListeners();
  }
 



  Future<void> saveMultipleFiles(String type) async{
    if(type=='images')
    {
      for(int i =0 ;i < _imageFilesWhatsappDir.length ; i++){
        var element = _imageFilesWhatsappDir[i] ;
        if(element.isSelected)
        {
          await SaveImageVideo.saveImage(element.imagePath);
        }
      }
      makeIsSelectedFilesFalse('savedImages');
      clearFilesList('savedImages');
      addFilesToList('savedImages');
    }
    else if(type=='videos')
    {
      for(int i =0 ;i < _videoFilesWhatsappDir.length ; i++){
        var element = _videoFilesWhatsappDir[i] ;
        if(element.isSelected)
        {
          await SaveImageVideo.saveVideo(element.videoPath);
        }
      }
      makeIsSelectedFilesFalse('savedVideos');
      clearFilesList('savedVideos');
      addFilesToList('savedVideos');
    }

    toggleisLongPress();
    notifyListeners();
  }

  void isSelectAllButtonFunctionality(String type){

      toggleIsSelectAll();
      if (isSelectAll) {
        makeIsSelectedTrue(type);
      }
      else if (type=='images' && !isSelectAll && countOfFilesSelected(type) != imageFilesWhatsappDirCount) {
        makeIsSelectedTrue(type);
      }
      else if (type=='videos' && !isSelectAll && countOfFilesSelected(type) != videoFilesWhatsappDirCount) {
        makeIsSelectedTrue(type);
      }
      else if (type=='savedImages' && !isSelectAll && countOfFilesSelected(type) != imageFilesSavedDirCount) {
        makeIsSelectedTrue(type);
      }
      else if (type=='savedVideos' && !isSelectAll && countOfFilesSelected(type) != videoFilesSavedDirCount) {
        makeIsSelectedTrue(type);
      }
      else if (!isSelectAll) {
        makeIsSelectedFilesFalse(type);
        toggleisLongPress();
      }

  }

  List<ImageFile> get imageFilesWhatsAppDir => _imageFilesWhatsappDir;
  List<VideoFile> get videoFilesWhatsAppDir => _videoFilesWhatsappDir;
  List<ImageFile> get imageFilesSavedDir => _imageFilesSavedDir;
  List<VideoFile> get videoFilesSavedDir => _videoFilesSavedDir;

  void toggleIsSelected(int index,String type){
    if(type=='images')
    {
      ImageFile image=_imageFilesWhatsappDir[index];
      image.toggleIsSelected();
    }
    else if(type=='videos')
    {
      VideoFile video=_videoFilesWhatsappDir[index];
      video.toggleIsSelected();
    }
    else if(type=='savedImages')
    {
      ImageFile image=_imageFilesSavedDir[index];
      image.toggleIsSelected();
    }
    else if(type=='savedVideos')
    {
      VideoFile video=_videoFilesSavedDir[index];
      video.toggleIsSelected();
    }
    notifyListeners();
  }


  void makeIsSelectedFilesFalse(String type){
    if(type=='images')
    {
      _imageFilesWhatsappDir.forEach((element) {
        element.makeIsSelectedFalse();
      });
    }
    else if(type=='videos')
    {
      _videoFilesWhatsappDir.forEach((element) {
        element.makeIsSelectedFalse();
      });
    }
    else if(type=='savedImages')
    {
        _imageFilesSavedDir.forEach((element) {
          element.makeIsSelectedFalse();
        });
    }
    else if(type=='savedVideos')
    {
        _videoFilesSavedDir.forEach((element) {
          element.makeIsSelectedFalse();
        });
    }
    notifyListeners();
  }


  void makeIsSelectedTrue(String type){

    if(type=='images')
    {
      _imageFilesWhatsappDir.forEach((element) {
        element.makeIsSelectedTrue();
      });
    }
    else if(type=='videos')
    {
      _videoFilesWhatsappDir.forEach((element) {
        element.makeIsSelectedTrue();
      });
    }
    else if(type=='savedImages')
    {
      _imageFilesSavedDir.forEach((element) {
        element.makeIsSelectedTrue();
      });
    }
    else if(type=='savedVideos')
    {
      _videoFilesSavedDir.forEach((element) {
        element.makeIsSelectedTrue();
      });
    }
    notifyListeners();
  }


  void clearFilesList(String type){
    if(type=='images')
    {
      _imageFilesWhatsappDir.clear();
    }
    else if(type=='videos')
    {
        _videoFilesWhatsappDir.clear();
    }
    else if(type=='savedImages')
    {
        _imageFilesSavedDir.clear();
    }
    else if(type=='savedVideos')
    {
        _videoFilesSavedDir.clear();
    }

    notifyListeners();
  }



  void addFilesToList(String type) async {
    List<FileSystemEntity> filesFromDir=[];
    List<String> filePathList=[];
    print("........type $type");
    if(type=='images')
    {
      filesFromDir=await whatsAppStatusDirectory.list().where((event) => (!event.path.contains('.nomedia') && !event.path.contains('.mp4'))).toList();
      filePathList=await Sort(fileNamesList: filesFromDir).sortFilesOnLastModifiedDate();

      filePathList.forEach((element) {
        _imageFilesWhatsappDir.add(ImageFile(imagePath:element));
      });

    }
    else if(type=='videos')
    {
      filesFromDir=await whatsAppStatusDirectory.list().where((event) => (!event.path.contains('.nomedia') && !event.path.contains('.jpg'))).toList();
      filePathList=await Sort(fileNamesList: filesFromDir).sortFilesOnLastModifiedDate();

      filePathList.forEach((element) {
        _videoFilesWhatsappDir.add(VideoFile(videoPath:element));
      });

    }
    else if(type=='savedImages')
    {
      print("Type $type");
      filesFromDir=await savedFilesDirectory.list().where((event) => (!event.path.contains('.nomedia') && !event.path.contains('.mp4'))).toList();
      filePathList=await Sort(fileNamesList: filesFromDir).sortFilesOnLastModifiedDate();

      filePathList.forEach((element) {
        _imageFilesSavedDir.add(ImageFile(imagePath:element));
      });
    }
    else if(type=='savedVideos')
    {
      filesFromDir=await savedFilesDirectory.list().where((event) => (!event.path.contains('.nomedia') && !event.path.contains('.jpg'))).toList();
      filePathList=await Sort(fileNamesList: filesFromDir).sortFilesOnLastModifiedDate();

      filePathList.forEach((element) {
        _videoFilesSavedDir.add(VideoFile(videoPath:element));
      });

    }
    notifyListeners();
  }


  Future<void> deleteSingleFile(String path,String type) async{
    if(type=='savedImages'){
      await File(path).delete(recursive: true);
      makeIsSelectedFilesFalse('savedImages');
      clearFilesList('savedImages');
      addFilesToList('savedImages');
    }
    else if(type=='savedVideos'){
      await File(path).delete(recursive: true);
      makeIsSelectedFilesFalse('savedVideos');
      clearFilesList('savedVideos');
      addFilesToList('savedVideos');
    }
    notifyListeners();
  }
  void deleteMultipleFiles(String type) {
    if(type=='savedImages'){
      _imageFilesSavedDir.forEach((element) async{
        if(element.isSelected){
          print("-------------------------${element.imagePath}");
          await File(element.imagePath).delete(recursive: true);
        }

      });

      makeIsSelectedFilesFalse('savedImages');
      clearFilesList('savedImages');
      addFilesToList('savedImages');

    }
    else if(type=='savedVideos'){
      _videoFilesSavedDir.forEach((element) async{
        if(element.isSelected){
          await File(element.videoPath).delete(recursive: true);
        }

      });

      makeIsSelectedFilesFalse('savedVideos');
      clearFilesList('savedVideos');
      addFilesToList('savedVideos');
    }

    toggleisLongPress();
    notifyListeners();
  }




}