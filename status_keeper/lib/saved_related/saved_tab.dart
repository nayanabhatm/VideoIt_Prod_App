import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:statuskeeper/constants.dart';
import 'package:statuskeeper/models/status_view_model.dart';
import 'package:statuskeeper/saved_related/images_grid_saved.dart';
import 'package:statuskeeper/saved_related/videos_grid_saved.dart';
import 'package:provider/provider.dart';

class SavedTab extends StatefulWidget {
  @override
  _SavedTabState createState() => _SavedTabState();
}

class _SavedTabState extends State<SavedTab> {

  @override
  Widget build(BuildContext context) {
    var viewModel=Provider.of<StatusViewModel>(context);
     return Column(
       children: <Widget>[
         ToggleButtons(
           constraints: BoxConstraints.expand(width: 200.0,height: 50.0),
           fillColor: Colors.lightGreen,
           children: <Widget>[
             Text("Images",
               style: TextStyle(
                   color: Colors.white,
                   fontSize: 14.0
               ),
             ),
             Text("Videos",
               style: TextStyle(
                   color: Colors.white,
                   fontSize: 14.0
               ),
             ),
           ],
           onPressed: (int index){
               viewModel.toggleToggleButtons(index);
           },
           isSelected: viewModel.toggleButtons,
         ),
         (viewModel.toggleButtonImage)? Expanded(
           child:ImagesGridSavedTab() ,
         ): Expanded(
           child:VideosGridSavedTab() ,
         )
       ],
     );
  }
}
