import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';

class VideoPlayScreen extends StatefulWidget {
  final String videoFileName;
  VideoPlayScreen({this.videoFileName});

  @override
  _VideoPlayScreenState createState() => _VideoPlayScreenState();
}

class _VideoPlayScreenState extends State<VideoPlayScreen> {

  final Directory whatsAppStatusDirectory=Directory('/storage/emulated/0/WhatsApp/Media/.Statuses');
  VideoPlayerController videoPlayerController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    videoFilesList();
  }


  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: (){

      },
      child: Container(
                  child: Align(
                    alignment: Alignment.center,
                    child: AspectRatio(
                        aspectRatio: 3/3,
                        child: VideoPlayer(videoPlayerController)),
                  )
      ),
    );
  }

  void videoFilesList() async{
    videoPlayerController=VideoPlayerController.file(File(widget.videoFileName));
    videoPlayerController.addListener((){setState(() { }); });
    await videoPlayerController.initialize();
    await videoPlayerController.setVolume(1.0);
    await videoPlayerController.setLooping(true);
    await videoPlayerController.play();
    setState(() {

    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    videoPlayerController.dispose();
    super.dispose();
  }


}
