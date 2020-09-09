import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:videoit/authentication/google_auth.dart';
import 'dart:io';
import 'package:videoit/formatNumber.dart';

import 'package:videoit/constants/SizeConfig.dart';

class VideoPlayScreen extends StatefulWidget {
  @override
  _VideoPlayScreenState createState() => _VideoPlayScreenState();
}

class _VideoPlayScreenState extends State<VideoPlayScreen> with WidgetsBindingObserver{
  final String videoFileUrl='https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4';
  //final String videoFileName='/storage/emulated/0/Status Keeper/VID-20181022-WA0000-1.mp4';
  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;
  Future<void> _futureInitializeVideoController;
  int likesCount=0,viewsCount=0;
  GoogleAuthentication googleAuthentication=GoogleAuthentication();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _videoPlayerController= VideoPlayerController.network(videoFileUrl);
    _futureInitializeVideoController=initVideoPlayer();
    setState(() {
    });
  }

  Future<void> initVideoPlayer() async {
     await _videoPlayerController.initialize();
     _chewieController = ChewieController(
      showControls: false,
      showControlsOnInitialize: false,
      aspectRatio:_videoPlayerController.value.aspectRatio,
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: true,
    );
     print(_chewieController.toString());
  }

   @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    if(state==AppLifecycleState.paused || state==AppLifecycleState.inactive||state==AppLifecycleState.detached){
      if(_videoPlayerController!=null){
        _videoPlayerController.pause();
      }
    }
    else if(state==AppLifecycleState.resumed){
      if(_videoPlayerController!=null){
        _videoPlayerController.play();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder(
        future: _futureInitializeVideoController,
        builder: (context,snapshot){
          if(snapshot.connectionState==ConnectionState.done)
            return Scaffold(
              drawer: Container(
                width: MediaQuery.of(context).size.width*0.3,
                child: Drawer(
                  child: ListView(
                    children: [
                      SizedBox(height: SizeConfig.safeBlockVertical*5),
                      Column(
                        children: [
                          IconButton(
                            onPressed: (){
                              _videoPlayerController.pause();
                              Navigator.pushNamed(context, '/myprofile');
                            },
                            icon: Icon(Icons.account_circle),
                            iconSize: 40.0,
                            color: Colors.pink,
                          ),
                          Text(
                            "My Profile",
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                      SizedBox(height: SizeConfig.safeBlockVertical*4),
                      Column(
                        children: [
                          IconButton(
                            onPressed: (){

                            },
                            icon: Icon(Icons.settings),
                            iconSize: 40.0,
                            color: Colors.blueAccent,
                          ),
                          Text(
                            "Settings",
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                      SizedBox(height: SizeConfig.safeBlockVertical*4),
                      Column(
                        children: [
                          IconButton(
                            onPressed: (){
                              googleAuthentication.logoutWithGoogle();
                              Navigator.pushReplacementNamed(context, '/');
                            },
                            icon: Icon(Icons.exit_to_app),
                            iconSize: 40.0,
                            color: Colors.purple,
                          ),
                          Text(
                            "Sign Out",
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                      SizedBox(height: SizeConfig.safeBlockVertical*5),
                    ],
                  ),
                ),
              ),
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
              ),
              body: Center(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                        if (_videoPlayerController.value.isPlaying) {
                          _videoPlayerController.pause();
                        } else {
                          _videoPlayerController.play();
                        }
                      },
                      child: Container(
                          child: AspectRatio(
                            aspectRatio:_videoPlayerController.value.aspectRatio,
                            child: Chewie(
                              controller: _chewieController,
                            ),
                          )
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              "   Lambargini chalayi",
                            ),
                            Text("  Lambargini chalayi")
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(Icons.account_circle),
                                  iconSize: 33.0,
                                  onPressed: (){
                                    print(snapshot.data);
                                    _videoPlayerController.pause();
                                    Navigator.pushNamed(context, '/userprofile');
                                  },
                                ),
                                Text('Profile')
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                IconButton(
                                    icon: Icon(Icons.thumb_up),
                                    iconSize: 33.0,
                                    onPressed: (){
                                      setState(() {
                                        likesCount++;
                                      });
                                    }
                                ),
                                Text(
                                  formatNumber(likesCount),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                IconButton(
                                    icon: Icon(Icons.remove_red_eye),
                                    iconSize: 33.0,
                                    onPressed: (){

                                    }
                                ),
                                Text(
                                  formatNumber(viewsCount),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                IconButton(
                                    icon: Icon(Icons.share),
                                    iconSize: 33.0,
                                    onPressed: (){

                                    }
                                ),
                                Text('Share')
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                IconButton(
                                    icon: Icon(Icons.camera_alt),
                                    iconSize: 33.0,
                                    onPressed: (){
                                        _videoPlayerController.pause();
                                        Navigator.pushNamed(context,'/videoRecording');
                                    }
                                ),
                                Text('VideoIt')
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 4.0,)
                      ],
                    ),
                  ],
                ),
              ),
            );
          else if(snapshot.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(backgroundColor: Colors.white, strokeWidth: 4.0,));
          }
          else if(snapshot.hasError)
            return Center(child: Text("${snapshot.error}"),
            );
          return Spacer();
        },
      ),
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }


}
