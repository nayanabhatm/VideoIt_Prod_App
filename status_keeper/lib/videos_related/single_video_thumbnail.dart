import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statuskeeper/models/video.dart';
import 'package:statuskeeper/models/status_view_model.dart';

class VideoCard extends StatefulWidget {
  final VideoFile videoFile;
  VideoCard({this.videoFile});

  @override
  _VideoCardState createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> with WidgetsBindingObserver{
  Future<Uint8List> bytes;

  @override
  void initState() {
    // TODO: implement initState
    print("videocard init");
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
        var viewModel=Provider.of<StatusViewModel>(context,listen: false);
        viewModel.makeSelectionModeLongPressFalse();
        bytes = viewModel.getVideoThumbnailBytes(widget.videoFile.videoPath);
    });
    super.initState();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    var viewModelVideosData=Provider.of<StatusViewModel>(context);

    return FutureBuilder(
      future: bytes,
      builder: (BuildContext context, AsyncSnapshot<Uint8List> snapshot){
        if(snapshot.hasData){
          return Container(
            child:  Card(
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Image.memory(
                    snapshot.data,
                    fit: BoxFit.cover,
                  ),

                  viewModelVideosData.isLongPress ?
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Icon(
                      widget.videoFile.isSelected ? Icons.check_box : Icons.check_box_outline_blank,
                      size: 30.0,
                      color: Colors.lightGreen,
                    ),
                  ) :  Container()
                ],
              ),
              elevation: 20.0,
            ),
          );
        }
        else{
          return Container(
            color: Colors.grey.withOpacity(0.2),
          );
        }
      },
    );
  }

}
