import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:videoit/pages/HomePage.dart';
import 'package:videoit/pages/LoginPage.dart';
import 'package:videoit/pages/VideoPlayPage.dart';
import 'package:videoit/pages/profile/MyProfilePage.dart';



void main() {

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
        "/userprofile" : (_)=> UserProfile('userProfile'),
        "/myprofile" : (_)=> UserProfile('myProfile'),
        "/videoplay" : (_) => VideoPlayScreen()
      },

    );
  }
}
