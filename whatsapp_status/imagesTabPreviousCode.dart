import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsappstatus/models/checkStoragePermission.dart';
import 'dart:io';
import 'lib/models/displayImageScreen.dart';
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
  List<bool> isSelected=[];

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
      isSelected.add(false);
    });

    setState(() {

    });

  }


  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
      body: Container(
        child: imageWidgetList.isEmpty ? Center(
            child: Text("No Status Available\n View WhatsApp Status and Come back Again")
        ):
        GridView.count(
            crossAxisCount: 3,
            children: List.generate( imageWidgetList.length, (index) {
              return GestureDetector(
                onTap: (){
                  if(isSelected[index]){
                    setState(() {
                      isSelected[index]=!isSelected[index];
                    });
                  }
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return DisplayImage(index: index, imageFilePath: imageWidgetList[index],);
                  }));
                },
                onLongPress: (){
                  isSelected[index]=!isSelected[index];
                  setState(() {

                  });
                },
                child: Hero(
                  tag: 'index$index',
                  child: Card(
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        Image.file(
                          File(imageWidgetList[index]),
                          fit: BoxFit.cover,
                          colorBlendMode: BlendMode.color,
                          color: Colors.black.withOpacity(isSelected[index]? 0.9 : 0 ),
                        ),
                        isSelected[index]?Align(
                          alignment: Alignment.bottomRight,
                          child: Icon(
                            Icons.check_box,
                            color: Colors.lightGreen,
                          ),
                        ):
                        Container()
                      ],
                    ),
                    elevation: 20.0,
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
