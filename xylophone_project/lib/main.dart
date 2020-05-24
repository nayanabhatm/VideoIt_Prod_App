import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';


void main(){
  runApp(XylophoneApp());
}

class XylophoneApp extends StatefulWidget {
  @override
  _XylophoneAppState createState() => _XylophoneAppState();
}

class _XylophoneAppState extends State<XylophoneApp> {
  int activeIndex = -1 ;
  Expanded buildKey({Color color,int soundNum,int index}) {
    return Expanded(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            FlatButton(
                color: color,
                onPressed: () {
                  final player = AudioCache();
                  player.play('note$soundNum.wav');

                  setState(() {
                    activeIndex = index ;
                  });

                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Transform.rotate(
                  angle: 3.142 / (index==activeIndex ? 2 : 9) ,
                  child: Image(
                    image: AssetImage('images/Slice1.png'),
                    alignment: Alignment.centerLeft,
                  ),
                ),
                Transform.rotate(
                  angle: -3.142 / (index==activeIndex ? 2 : 9 ),
                  child: Image(
                    image: AssetImage('images/Slice1.png'),
                    alignment: Alignment.centerRight,
                  ),
                )
              ],
            )
          ],
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "XylophoneApp",
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildKey(color:Colors.red, soundNum:1,index:0),
              buildKey(color:Colors.orangeAccent, soundNum:2,index:1),
              buildKey(color:Colors.yellowAccent, soundNum:3,index:2),
              buildKey(color:Colors.green, soundNum:4,index:3),
              buildKey(color:Colors.teal, soundNum:5,index:4),
              buildKey(color:Colors.blue, soundNum:6,index:5),
              buildKey(color:Colors.purple, soundNum:7,index:6),

            ],
          ),
        ),
      ),
    );
  }
}
