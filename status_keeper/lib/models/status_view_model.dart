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

  bool _isSelectionModeImagesTab = false;
  bool _isSelectionModeVideosTab=false;
  bool _isSelectionModeSavedImagesTab=false;
  bool _isSelectionModeSavedVideosTab=false;
  bool _selectAll=false;

  List<bool> _toggleButtonSelection=[true,false];
  List<ImageFile> _imageFilesWhatsappDir=[];
  List<VideoFile> _videoFilesWhatsappDir=[];
  List<ImageFile> _imageFilesSavedDir=[];
  List<VideoFile> _videoFilesSavedDir=[];

  void toggleToggleButtons(int index){
    for (int i = 0; i < _toggleButtonSelection.length; i++) {
      _toggleButtonSelection[i] = i == index;
    }
    notifyListeners();
  }

  bool get toggleButtonImage => _toggleButtonSelection[0];
  bool get toggleButtonVideo => _toggleButtonSelection[1];
  List<bool> get toggleButtons => _toggleButtonSelection;


  Future<Uint8List> getVideoThumbnailBytes(String path) async{
    Uint8List bytes=await VideoThumbnail.thumbnailData(
      video: path,
      imageFormat: ImageFormat.PNG,
      quality: 25,
    ) ;
    return bytes;
  }


  bool get isSelectionModeImagesTab => _isSelectionModeImagesTab;
  bool get isSelectionModeVideosTab => _isSelectionModeVideosTab;
  bool get isSelectionModeSavedVideosTab => _isSelectionModeSavedVideosTab;
  bool get isSelectionModeSavedImagesTab => _isSelectionModeSavedImagesTab;

  void makeSelectionModeFalse(String type){
    if(type=='images')
      {
        _isSelectionModeImagesTab=false;
      }
    else if(type=='videos')
      {
        _isSelectionModeVideosTab=false;
      }
    else if(type=='savedImages')
      {
        _isSelectionModeSavedImagesTab=false;
      }
    else if(type=='savedVideos')
      {
        _isSelectionModeSavedVideosTab=false;
      }
    notifyListeners();
  }

  void toggleSelectionModel(String type){
    if(type=='images')
    {
      _isSelectionModeImagesTab=!_isSelectionModeImagesTab;
    }
    else if(type=='videos')
    {
      _isSelectionModeVideosTab=!_isSelectionModeVideosTab;
    }
    else if(type=='savedImages')
    {
      _isSelectionModeSavedImagesTab=!_isSelectionModeSavedImagesTab;
    }
    else if(type=='savedVideos')
    {
      _isSelectionModeSavedVideosTab=!_isSelectionModeSavedVideosTab;
    }
    notifyListeners();
  }


  bool get selectAll => _selectAll;
  void toggleSelectAll(){
    _selectAll=!_selectAll;
    notifyListeners();
  }
  void makeSelectAllFalse(){
    _selectAll=false;
    notifyListeners();
  }


  int get imageFilesCount => _imageFilesWhatsappDir.length;
  int get videoFilesCount => _videoFilesWhatsappDir.length;
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
      makeSelectedFilesFalse('savedImages');
      clearFilesList('savedImages');
      addFilesToList('savedImages');
    }
    else if(type=='videos')
    {
      await SaveImageVideo.saveVideo(path);
      makeSelectedFilesFalse('savedVideos');
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
    }

    makeSelectedFilesFalse('savedImages');
    clearFilesList('savedImages');
    addFilesToList('savedImages');

    makeSelectedFilesFalse('savedVideos');
    clearFilesList('savedVideos');
    addFilesToList('savedVideos');

    notifyListeners();
  }


  List<ImageFile> get imageFilesWhatsAppDir => _imageFilesWhatsappDir;
  List<VideoFile> get videoFilesWhatsAppDir => _videoFilesWhatsappDir;
  List<ImageFile> get imageFilesSavedDir => _imageFilesSavedDir;
  List<VideoFile> get videoFilesSavedDir => _videoFilesSavedDir;

  void toggleSelectedFile(int index,String type){
    if(type=='images')
    {
      ImageFile image=_imageFilesWhatsappDir[index];
      image.toggleSelected();
    }
    else if(type=='videos')
    {
      VideoFile video=_videoFilesWhatsappDir[index];
      video.toggleSelected();
    }
    else if(type=='savedImages')
    {
      ImageFile image=_imageFilesSavedDir[index];
      image.toggleSelected();
    }
    else if(type=='savedVideos')
    {
      VideoFile video=_videoFilesSavedDir[index];
      video.toggleSelected();
    }
    notifyListeners();
  }


  void makeSelectedFilesFalse(String type){
    if(type=='images')
    {
      _imageFilesWhatsappDir.forEach((element) {
        element.makeSelectedFalse();
      });
    }
    else if(type=='videos')
    {
      _videoFilesWhatsappDir.forEach((element) {
        element.makeSelectedFalse();
      });
    }
    else if(type=='savedImages')
    {
        _imageFilesSavedDir.forEach((element) {
          element.makeSelectedFalse();
        });
    }
    else if(type=='savedVideos')
    {
        _videoFilesSavedDir.forEach((element) {
          element.makeSelectedFalse();
        });
    }
    notifyListeners();
  }


  void makeSelectedFilesTrue(String type){

    if(type=='images')
    {
      _imageFilesWhatsappDir.forEach((element) {
        element.makeSelectedTrue();
      });
    }
    else if(type=='videos')
    {
      _videoFilesWhatsappDir.forEach((element) {
        element.makeSelectedTrue();
      });
    }
    else if(type=='savedImages')
    {
      _imageFilesSavedDir.forEach((element) {
        element.makeSelectedTrue();
      });
    }
    else if(type=='savedVideos')
    {
      _videoFilesSavedDir.forEach((element) {
        element.makeSelectedTrue();
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
      await File(path).delete();
      makeSelectedFilesFalse('savedImages');
      clearFilesList('savedImages');
      addFilesToList('savedImages');
    }
    else if(type=='savedVideos'){
      await File(path).delete();
      makeSelectedFilesFalse('savedVideos');
      clearFilesList('savedVideos');
      addFilesToList('savedVideos');
    }
    notifyListeners();
  }
  void deleteMultipleFiles(String type) {
    if(type=='savedImages'){
      _imageFilesSavedDir.forEach((element) async{
        if(element.isSelected){
          await File(element.imagePath).delete();
        }

      });

      makeSelectedFilesFalse('savedImages');
      clearFilesList('savedImages');
      addFilesToList('savedImages');

    }
    else if(type=='savedVideos'){
      _videoFilesSavedDir.forEach((element) async{
        if(element.isSelected){
          await File(element.videoPath).delete();
        }

      });

      makeSelectedFilesFalse('savedVideos');
      clearFilesList('savedVideos');
      addFilesToList('savedVideos');
    }

    notifyListeners();
  }




}