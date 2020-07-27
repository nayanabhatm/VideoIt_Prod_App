import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'dart:io';
import '../models/videoPlayScreen.dart';
import 'dart:collection';


class VideoThumbnailsTab extends StatefulWidget {
  @override
  _VideoThumbnailsTabState createState() => _VideoThumbnailsTabState();
}

class _VideoThumbnailsTabState extends State<VideoThumbnailsTab> with AutomaticKeepAliveClientMixin,WidgetsBindingObserver {
  final Directory whatsAppStatusDirectory=Directory('/storage/emulated/0/WhatsApp/Media/.Statuses');
  List<FileSystemEntity> videoNamesInWhatsAppDirectory=[];
  List<Uint8List> thumbnailImages=[];
  Map<String,DateTime> tempVideoNamesWithDateTimeMap=Map();
  List<dynamic> reverseSortedVideoFileNames=[];

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
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

    //create a Map with Filename as key and lastmodifieddate as value.
    for(int i=0;i<videoNamesInWhatsAppDirectory.length;i++){
      String filePathOfVideo=videoNamesInWhatsAppDirectory[i].path;
      tempVideoNamesWithDateTimeMap[filePathOfVideo]=await File(filePathOfVideo).lastModified();
    }

    //sort the map based on the datetime value
    var sortedVideoNamesWithDateTime = tempVideoNamesWithDateTimeMap.keys.toList();
    sortedVideoNamesWithDateTime.sort((k1, k2) => tempVideoNamesWithDateTimeMap[k1].compareTo(tempVideoNamesWithDateTimeMap[k2]));
    LinkedHashMap tempSortedVideoNameMap = LinkedHashMap.fromIterable(sortedVideoNamesWithDateTime, key: (k) => k, value: (k) => tempVideoNamesWithDateTimeMap[k]);

    //Now, the filenames/keys are in sorted order based on lastmodified date. Reverse the keys and create a thumbnails.
    reverseSortedVideoFileNames=tempSortedVideoNameMap.keys.toList().reversed.toList();

   for(int i=0;i<reverseSortedVideoFileNames.length;i++)
   {
      thumbnailImages.add(await VideoThumbnail.thumbnailData(
        video: reverseSortedVideoFileNames[i],
        imageFormat: ImageFormat.PNG,
        quality: 100,
      ));
    }
    setState(() {

    });

  }

  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: thumbnailImages.isEmpty ? Center(
          child: Text("No Status Available\n View WhatsApp Status and Come back Again")
      ):
      GridView.count(
          crossAxisCount: 3,
          children: List.generate( thumbnailImages.length, (index) {
            return GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return VideoPlayScreen(videoFileName:reverseSortedVideoFileNames[index]);
                }));
              },
              child: Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Card(
                    child: Image.memory(
                        thumbnailImages[index],
                      fit: BoxFit.cover,
                    ),
                    elevation: 20.0,
                  ),
                ),
              ),
            );
          })
      )
    );
  }
}
