import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsappstatus/checkStoragePermission.dart';
import 'dart:io';
import 'displayImageScreen.dart';

class ImagesTab extends StatefulWidget {
    @override
  _ImagesTabState createState() => _ImagesTabState();
}

class _ImagesTabState extends State<ImagesTab> with AutomaticKeepAliveClientMixin,WidgetsBindingObserver{
  final Directory whatsAppStatusDirectory=Directory('/storage/emulated/0/WhatsApp/Media/.Statuses');
  List<FileSystemEntity> imageNamesInWhatsAppDirectory=[];
  List<Image> imageWidgetList=[];
  int gridCount=2;

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
          imageNamesInWhatsAppDirectory.clear();
          createImagesFromFilesInWhatsAppDirectory();
        }
  }


  void createImagesFromFilesInWhatsAppDirectory() async {
     imageNamesInWhatsAppDirectory=await whatsAppStatusDirectory.list().where((event) => (!event.path.contains('.nomedia') && !event.path.contains('.mp4'))).toList();
     for(int i=0;i<imageNamesInWhatsAppDirectory.length;i++){
       imageWidgetList.insert(0, Image.file(imageNamesInWhatsAppDirectory[i],fit: BoxFit.fitWidth,)
       );
     }
     setState(() {

     });

  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return GestureDetector(
      onScaleStart:(details){
      },
      onScaleUpdate: (details){
        print(details.scale);
        if(details.scale.toInt()<=1) {
          if (gridCount + 1 <= 4)
            gridCount++;
        }
        else
        {
          if (gridCount - 1 >= 2)
            gridCount--;
        }
        setState(() {
        });
      },
      onScaleEnd: (ScaleEndDetails details){

      },
      child: Container(
            child: imageWidgetList.isEmpty ? Center(child: CircularProgressIndicator()):
            GridView.count(
                crossAxisCount: gridCount,
                children: List.generate( imageWidgetList.length, (index) {
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return DisplayImage(index: index, imageValue: imageWidgetList[index],);
                      }));
                    },
                    child: Hero(
                      tag: 'index$index',
                      child: Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(22.0),
                          child: Card(
                            child: imageWidgetList[index],
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
