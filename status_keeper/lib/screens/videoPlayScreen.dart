import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';
import 'package:statuskeeper/functionalities/saveImageOrVideo.dart';
import 'package:statuskeeper/constants.dart';
import 'package:statuskeeper/functionalities/shareImageOrVideo.dart';
import 'package:chewie/chewie.dart';
import 'package:statuskeeper/models/status_view_model.dart';

class VideoPlayScreen extends StatefulWidget {
  final int index;
  final String videoFileName;
  VideoPlayScreen({this.index,this.videoFileName});

  @override
  _VideoPlayScreenState createState() => _VideoPlayScreenState();
}

class _VideoPlayScreenState extends State<VideoPlayScreen> {
  VideoPlayerController videoPlayerController;
  ChewieController chewieController;

  @override
  void initState() {
    super.initState();
    videoPlayerController= VideoPlayerController.file(File(widget.videoFileName));
    chewieController = ChewieController(
      aspectRatio:videoPlayerController.value.aspectRatio,
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      looping: true,
      cupertinoProgressColors: ChewieProgressColors(
        handleColor: Colors.lightGreenAccent,
        bufferedColor: Colors.grey,
        playedColor: Colors.white,
      ),
      materialProgressColors: ChewieProgressColors(
        handleColor: Colors.lightGreenAccent,
        bufferedColor: Colors.grey,
        playedColor: Colors.white,
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    var viewModelData=Provider.of<StatusViewModel>(context);
    return Scaffold(
      backgroundColor: Colors.black,
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
                   viewModelData.saveSingleFile(widget.videoFileName,'videos');
                    Scaffold.of(context).showSnackBar(kSnackBarForSaved);
                  },
              ),
          ),
          IconButton(
            tooltip: "Share",
            icon: Icon(Icons.share),
            onPressed: (){
              ShareImageVideo.shareImageVideo(widget.videoFileName,'file');
            },
          ),
          SizedBox(width: 15.0,)
        ],
      ),
      body: Center(
        child: Container(
            child: AspectRatio(
              aspectRatio:videoPlayerController.value.aspectRatio,
              child: Chewie(
                controller: chewieController,
              ),
            )
        ),
      ),
    );
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }


}
