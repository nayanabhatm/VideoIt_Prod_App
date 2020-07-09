import 'package:flutter/material.dart';
import 'package:whatsappstatus/imagesTab.dart';
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
            primaryColorLight: Colors.lightGreen,
          snackBarTheme: SnackBarThemeData(
            backgroundColor: Colors.lightGreenAccent
          )
        ),
        home: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              title: Text("Status Saver"),
              bottom: TabBar(
                tabs: [
                  Tab(text:"Images"),
                  Tab(text:"Videos"),
                  Tab(text:"Saved"),
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




