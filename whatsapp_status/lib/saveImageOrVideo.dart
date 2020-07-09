import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';


class SaveImageVideo{

  void saveFileToDirectory() async{
    Directory saveDirectory=await getApplicationDocumentsDirectory();
    print(saveDirectory.path);
  }


  void saveImage(String path){
    GallerySaver.saveImage(path,albumName: 'Status Saver').then((bool success) {
      saveFileToDirectory();
    });
  }

  void saveVideo(String path){
    GallerySaver.saveVideo(path,albumName: 'Status Saver').then((bool success) {
      saveFileToDirectory();
    });
  }


}


