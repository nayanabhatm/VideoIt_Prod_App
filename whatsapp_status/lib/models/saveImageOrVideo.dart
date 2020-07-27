import 'dart:core';
import 'package:gallery_saver/gallery_saver.dart';


import 'package:path_provider/path_provider.dart';

class SaveImageVideo{

  static Future<bool> saveImage(String path) async{
    return await GallerySaver.saveImage(path,albumName: 'testtest');
  }

}


