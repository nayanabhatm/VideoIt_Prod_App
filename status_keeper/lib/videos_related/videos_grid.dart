import 'package:flutter/material.dart';
import 'package:statuskeeper/models/status_view_model.dart';
import 'package:provider/provider.dart';
import 'package:statuskeeper/screens/videoPlayScreen.dart';
import 'package:statuskeeper/videos_related/single_video_thumbnail.dart';

class VideosGrid extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var viewModelVideosData = Provider.of<StatusViewModel>(context , listen: false);
    return GridView.builder(
        gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 1.0,
          mainAxisSpacing: 1.0,
        ),
        itemCount: viewModelVideosData.videoFilesWhatsappDirCount ,
        itemBuilder:(context,index){
          return Container(
            child: GestureDetector(
              onTap: (){
                if(!viewModelVideosData.isLongPress){
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return VideoPlayScreen(index:index, videoFileName:viewModelVideosData.videoFilesWhatsAppDir[index].videoPath);
                  })
                  );
                }
                else {
                  viewModelVideosData.toggleIsSelected(index,'videos');
                }
              },
              onLongPress: () {
                if(!viewModelVideosData.isLongPress)
                  viewModelVideosData.makeIsSelectedFilesFalse('videos');

                viewModelVideosData.toggleisLongPress();
                viewModelVideosData.toggleIsSelected(index,'videos');
              },

              child: VideoCard(
                videoFile:viewModelVideosData.videoFilesWhatsAppDir[index],
              ),
            ),
          );
        }
    );
  }
}


