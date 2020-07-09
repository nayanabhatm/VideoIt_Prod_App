import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsappstatus/checkStoragePermission.dart';
import 'dart:io';
import 'displayImageScreen.dart';
import 'dart:collection';

class ImagesTab extends StatefulWidget {
    @override
  _ImagesTabState createState() => _ImagesTabState();
}

class _ImagesTabState extends State<ImagesTab> with AutomaticKeepAliveClientMixin,WidgetsBindingObserver{
  final Directory whatsAppStatusDirectory=Directory('/storage/emulated/0/WhatsApp/Media/.Statuses');
  List<FileSystemEntity> listOfImagesInWhatsAppDirectory=[];
  List<String> imageWidgetList=[];
  Map<String,DateTime> tempImageNamesWithDateTimeMap=Map();

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
      super.initState();
      print("init");
      WidgetsBinding.instance.addObserver(this);
      PermissionCheck().checkStoragePermission();
      createImagesFromFilesInWhatsAppDirectory();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    if(state==AppLifecycleState.paused || state==AppLifecycleState.resumed || state==AppLifecycleState.inactive)
        {
          imageWidgetList.clear();
          listOfImagesInWhatsAppDirectory.clear();
          createImagesFromFilesInWhatsAppDirectory();
        }
  }


  void createImagesFromFilesInWhatsAppDirectory() async {
     listOfImagesInWhatsAppDirectory=await whatsAppStatusDirectory.list().where((event) => (!event.path.contains('.nomedia') && !event.path.contains('.mp4'))).toList();

     for(int i=0;i<listOfImagesInWhatsAppDirectory.length;i++){
       String filePathOfImage=listOfImagesInWhatsAppDirectory[i].path;
       tempImageNamesWithDateTimeMap[filePathOfImage]=await File(filePathOfImage).lastModified();
     }

     var sortedImageNamesWithDateTime = tempImageNamesWithDateTimeMap.keys.toList();
     sortedImageNamesWithDateTime.sort((k1, k2) => tempImageNamesWithDateTimeMap[k1].compareTo(tempImageNamesWithDateTimeMap[k2]));
     LinkedHashMap tempSortedImageNameMap = LinkedHashMap.fromIterable(sortedImageNamesWithDateTime, key: (k) => k, value: (k) => tempImageNamesWithDateTimeMap[k]);

     tempSortedImageNameMap.keys.toList().reversed.forEach((element) {
       imageWidgetList.add(element);
     });

     setState(() {

     });

  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return GestureDetector(
//      onScaleStart:(details){
//      },
//      onScaleUpdate: (details){
//        print(details.scale);
//        if(details.scale.toInt()<=1) {
//          if (gridCount + 1 <= 4)
//            gridCount++;
//        }
//        else
//        {
//          if (gridCount - 1 >= 2)
//            gridCount--;
//        }
//        setState(() {
//        });
//      },
//      onScaleEnd: (ScaleEndDetails details){
//
//      },
      child: Container(
            child: imageWidgetList.isEmpty ? Center(child: CircularProgressIndicator()):
            GridView.count(
                crossAxisCount: 3,
                children: List.generate( imageWidgetList.length, (index) {
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return DisplayImage(index: index, imageFilePath: imageWidgetList[index],);
                      }));
                    },
                    child: Hero(
                      tag: 'index$index',
                      child: Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: Card(
                            child: Image.file(File(imageWidgetList[index]),fit: BoxFit.cover,),
                            elevation: 20.0,
                          ),
                        ),
                      ),
                    ),
                  );
                })
            ),
      ),
    );
  }


  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance.removeObserver(this);
    print("dispose");
    super.dispose();
  }

}
