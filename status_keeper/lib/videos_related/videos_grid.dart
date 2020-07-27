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
        itemCount: viewModelVideosData.videoFilesCount ,
        itemBuilder:(context,index){
          return Container(
            child: GestureDetector(
              onTap: (){
                if(!viewModelVideosData.isSelectionModeVideosTab){
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return VideoPlayScreen(index:index, videoFileName:viewModelVideosData.videoFilesWhatsAppDir[index].videoPath);
                  })
                  );
                }
                else {
                  viewModelVideosData.toggleSelectedFile(index,'videos');
                }
              },
              onLongPress: () {
                if(!viewModelVideosData.isSelectionModeVideosTab)
                  viewModelVideosData.makeSelectedFilesFalse('videos');

                viewModelVideosData.toggleSelectionModel('videos');
                viewModelVideosData.toggleSelectedFile(index,'videos');
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


