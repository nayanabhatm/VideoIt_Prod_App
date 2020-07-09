import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';
import 'saveImageOrVideo.dart';
import 'constants.dart';
import 'shareImageOrVideo.dart';
import 'package:chewie/chewie.dart';

class VideoPlayScreen extends StatefulWidget {
  final String videoFileName;
  VideoPlayScreen({this.videoFileName});

  @override
  _VideoPlayScreenState createState() => _VideoPlayScreenState();
}

class _VideoPlayScreenState extends State<VideoPlayScreen> {

  final Directory whatsAppStatusDirectory=Directory('/storage/emulated/0/WhatsApp/Media/.Statuses');
  VideoPlayerController videoPlayerController;
  SaveImageVideo saveImageVideo=SaveImageVideo();
  ShareImageVideo shareImageVideo=ShareImageVideo();
  ChewieController chewieController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    videoFilesList();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Videos"),
        backgroundColor: Colors.black,
        actions: <Widget>[
          Builder(
            builder: (context)=>
                IconButton(
                  tooltip: "Save",
                  icon: Icon(Icons.save),
                  onPressed: (){
                    saveImageVideo.saveVideo(widget.videoFileName);
                    Scaffold.of(context).showSnackBar(kSnackBarForVideoSave);
                  },
                ),
          ),
          IconButton(
            tooltip: "Share",
            icon: Icon(Icons.share),
            onPressed: (){
              shareImageVideo.shareImageVideo(widget.videoFileName,'video');
            },
          ),
          IconButton(
            tooltip: "Repost",
            icon: Icon(Icons.repeat),
            onPressed: (){

            },
          ),
          SizedBox(width: 10.0,)
        ],
      ),
      body: Center(
        child: Container(
            child: Chewie(
              controller: chewieController,
            )
        ),
      ),
    );
  }

  void videoFilesList() async{
    videoPlayerController= VideoPlayerController.file(File(widget.videoFileName));

    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: videoPlayerController.value.aspectRatio,
      autoPlay: true,
      looping: true,
      cupertinoProgressColors: ChewieProgressColors(
          handleColor: Colors.lightGreenAccent,
          bufferedColor: Colors.grey,
          playedColor: Colors.white
      ),
      materialProgressColors: ChewieProgressColors(
        handleColor: Colors.lightGreenAccent,
          bufferedColor: Colors.grey,
          playedColor: Colors.white
      ),
    );

    setState(() {

    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }


}
