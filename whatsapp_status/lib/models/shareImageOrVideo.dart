import 'package:share_extend/share_extend.dart';

class ShareImageVideo{
  void shareImageVideo(String path,String type) async{
    print("...$path..");
    ShareExtend.share(path, type, sharePositionOrigin: null);
  }

  void shareImageVideoMultiple(List<String> pathList, String type) async{
    print("Share multiple $pathList");
    ShareExtend.shareMultiple(pathList, type);
  }
}