import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:videoit/pages/HomePage.dart';
import 'package:videoit/pages/LoginPage.dart';
import 'package:videoit/pages/VideoPlayPage.dart';
import 'package:videoit/pages/VideoRecordingPage.dart';
import 'package:videoit/pages/profile/MyProfilePage.dart';
import 'package:videoit/pages/profile/UserProfilePage.dart';


Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      theme: ThemeData(
        iconTheme: IconThemeData(
          color:Colors.white
        ),
        textTheme: TextTheme(
          bodyText1: TextStyle(),
          bodyText2: TextStyle(),
        ).apply(
          displayColor: Colors.white,
          bodyColor: Colors.white
        ),
        canvasColor: Colors.transparent,
        accentColor: Colors.grey,
      ),
      title: 'VideoIt',
      routes: {
        "/" : (_)=> HomePage(),
        "/login" : (_)=> LoginPage(),
        "/userprofile" : (_)=> UserProfile(),
        "/myprofile" : (_)=> MyUserProfile(),
        "/videoplay" : (_) => VideoPlayScreen(),
        "/videoRecording" : (_)=> VideoRecording(),
      },

    );
  }
}




//import 'dart:developer';
//
//import 'package:dio/dio.dart';
//import 'package:videoit/models/service_api_response_models.dart';
//import 'package:videoit/service_api.dart';
//import 'package:videoit/service_api_calls.dart';
//
//
//
//void main() async {
//  final dio = Dio(); // Provide a dio instance// config your dio headers globally
//  final client = RestClient(dio);
//
//  try{
//    var response= await client.getVideoStreamUrl('dn', '6a9ec877-6e97-455a-a358-756fb1320bd5', '2c9280887444a7e10174450daa400000');
//    log(response.url);
//  }
//  catch(e){
//    print(e);
//  }
//
//  try{
//    var bb=await client.getVideoDetails("dn",'6a9ec877-6e97-455a-a358-756fb1320bd5',  '2c9280887444a7e10174450daa400000');
//    print(bb.uuid);
//
//  }
//  catch(e){
//    print(e);
//  }
//
//
////  try{
////    print("calling");
////    Future fut;
////    fut=client.getUserVideos('dn','6a9ec877-6e97-455a-a358-756fb1320bd5','6a9ec877-6e97-455a-a358-756fb1320bd5', 1);
////    print("----$fut");
////    fut.then((value) => print("uservideodetails: ${value[0].videoId} ${value[1].videoId} \n\n\n-----$value"));
////  }
////  catch(e){
////    print(e);
////  }
//
//  try{
//    print("serviceapi");
//    Future fut;
//    fut=ServiceAPI().getUserVideos();
//    log("--ffff--$fut");
//    fut.then((value) => log("//////uservideodetails: ${value[0].videoId} ${value[1].videoId} \n\n\n-----$value"));
//  }
//  catch(e){
//    print(e);
//  }
//
//}
