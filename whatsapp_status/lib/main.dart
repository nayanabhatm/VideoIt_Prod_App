import 'package:flutter/material.dart';
import 'package:whatsappstatus/imagesTab.dart';
import 'package:whatsappstatus/videoPlayScreen.dart';
import 'videosTab.dart';

void main() {
  runApp(WhatsAppStatus());
}

class WhatsAppStatus extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
        title: 'WhatsAppStatus Saver',
        theme: ThemeData.dark().copyWith(
            primaryColor: Colors.lightGreen,
            indicatorColor: Colors.lightGreen,
            primaryColorLight: Colors.lightGreen
        ),
        home: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              title: Text("WhatsAppStatus Saver"),
              bottom: TabBar(
                tabs: [
                  Tab(text:"Images",icon: Icon(Icons.image),),
                  Tab(text:"Videos",icon:Icon(Icons.video_label)),
                  Tab(text:"Saved",icon:Icon(Icons.save)),
                ],
              ),
            ),
            body: TabBarView(
                children: [
                  ImagesTab(),
                  VideoThumbnailsTab(),
                  Container(color:Colors.blue),
                ]),
          ),
        )
    );
  }


}




