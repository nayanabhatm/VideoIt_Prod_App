import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:videoit/authentication/google_auth.dart';
import 'dart:io';

import 'package:videoit/constants/SizeConfig.dart';

class VideoPlayScreen extends StatefulWidget {
  @override
  _VideoPlayScreenState createState() => _VideoPlayScreenState();
}

class _VideoPlayScreenState extends State<VideoPlayScreen> with WidgetsBindingObserver{
  //final String videoFileUrl='https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4';
  final String videoFileName='/storage/emulated/0/Status Keeper/VID-20181022-WA0000-1.mp4';
  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;
  Future<void> _futureInitializeVideoController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _videoPlayerController= VideoPlayerController.file(File(videoFileName));
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
    print("..........state: $state");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder(
        future: _futureInitializeVideoController,
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator(
              backgroundColor: Colors.white,
            ));
          else if(snapshot.hasError)
              return Center(child: Text("${snapshot.error}"),
              );
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
                             Navigator.pushNamed(context, '/userprofile');
                           },
                           icon: Icon(Icons.account_circle),
                           iconSize: 40.0,
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
                                  Auth.logoutWithGoogle();
                                  Navigator.pushReplacementNamed(context, '/');
                           },
                           icon: Icon(Icons.exit_to_app),
                           iconSize: 40.0,
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
                          Text("    Description    "),
                          Text("  Song")
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(Icons.account_circle),
                              Text('Profile')
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(Icons.thumb_up),
                              Text('12'),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(Icons.remove_red_eye),
                              Text('40')
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(Icons.share),
                              Text('Share')
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(Icons.camera_alt),
                              Text('VideoIt')
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
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
