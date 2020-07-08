import 'dart:typed_data';
import 'package:whatsappstatus/checkStoragePermission.dart';
import 'package:flutter/material.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'dart:io';
import 'videoPlayScreen.dart';


class VideoThumbnailsTab extends StatefulWidget {
  @override
  _VideoThumbnailsTabState createState() => _VideoThumbnailsTabState();
}

class _VideoThumbnailsTabState extends State<VideoThumbnailsTab> with AutomaticKeepAliveClientMixin,WidgetsBindingObserver {
  final Directory whatsAppStatusDirectory=Directory('/storage/emulated/0/WhatsApp/Media/.Statuses');
  List<FileSystemEntity> videoNamesInWhatsAppDirectory=[];
  List<Uint8List> thumbnailImages=[];

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    PermissionCheck().checkStoragePermission();
    createThumbnails();
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    if(state==AppLifecycleState.paused || state==AppLifecycleState.resumed || state==AppLifecycleState.inactive)
    {
      videoNamesInWhatsAppDirectory.clear();
      thumbnailImages.clear();
      createThumbnails();
    }
  }

  void createThumbnails() async{
    videoNamesInWhatsAppDirectory = await whatsAppStatusDirectory.list().where((event) => (!event.path.contains('.nomedia') &&
        !event.path.contains('.jpg')))
        .toList();


    for(int i=0;i<videoNamesInWhatsAppDirectory.length;i++){
      thumbnailImages.insert(0, await VideoThumbnail.thumbnailData(
        video: videoNamesInWhatsAppDirectory[i].path,
        imageFormat: ImageFormat.JPEG,
        quality: 100,
      ));
      print("bytesletnght: ${thumbnailImages[i].length}");
    }

    setState(() {

    });

  }

  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: thumbnailImages.isEmpty ? Center(child: CircularProgressIndicator()):
      GridView.count(
          crossAxisCount: 2,
          children: List.generate( thumbnailImages.length, (index) {
            return GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return VideoPlayScreen(videoFileName:videoNamesInWhatsAppDirectory[index].path);
                }));
              },
              child: Hero(
                tag: index,
                child: Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(22.0),
                    child: Card(
                      child: Stack(
                        fit: StackFit.expand,
                          children: <Widget>[
                            Image.memory(
                                thumbnailImages[index],
                              fit: BoxFit.fill,
                            ),
                            Center(
                                child: Icon(Icons.play_circle_outline,size: 70.0,)
                            )
                          ],
                      ),
                      elevation: 20.0,
                    ),
                  ),
                ),
              ),
            );
          })
      )
    );
  }
}
