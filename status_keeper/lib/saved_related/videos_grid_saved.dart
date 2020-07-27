import 'package:flutter/material.dart';
import 'package:statuskeeper/models/status_view_model.dart';
import 'package:provider/provider.dart';
import 'package:statuskeeper/screens/videoPlayScreen.dart';
import 'package:statuskeeper/saved_related/single_video_thumbnail_saved.dart';

class VideosGridSavedTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var viewModelVideosData = Provider.of<StatusViewModel>(context , listen: false);
    return GridView.builder(
          gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 1.0,
            mainAxisSpacing: 1.0,
          ),
          itemCount: viewModelVideosData.videoFilesSavedDirCount ,
          itemBuilder:(context,index){
            return Container(
              child: GestureDetector(
                onTap: (){
                  if(!viewModelVideosData.isSelectionModeSavedVideosTab){
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return VideoPlayScreen(index:index, videoFileName:viewModelVideosData.videoFilesSavedDir[index].videoPath);
                    })
                    );
                  }
                  else {
                    viewModelVideosData.toggleSelectedFile(index,'savedVideos');
                  }
                },
                onLongPress: () {
                  if(!viewModelVideosData.isSelectionModeSavedVideosTab)
                    viewModelVideosData.makeSelectedFilesFalse('savedVideos');

                  viewModelVideosData.toggleSelectionModel('savedVideos');
                  viewModelVideosData.toggleSelectedFile(index,'savedVideos');
                },

                child: VideoCardSaved(
                  videoFile:viewModelVideosData.videoFilesSavedDir[index],
                ),
              ),
            ) ;
          }
      );
  }
}


