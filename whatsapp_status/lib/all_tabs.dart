import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'tabs/imagesTab.dart';
import 'tabs/videosTab.dart';
import 'tabs/savedTab.dart';
import 'data/status_view_model.dart';
import 'constants.dart';

class Tabs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<StatusViewModel>(
      create: (context) => StatusViewModel(),
      child: Builder(
        builder: (context){
          return Scaffold(
            appBar: buildAppBar(context),
            body: TabBarView(
                children: [
                  ImagesTab(),
                  Container(),
                  //VideoThumbnailsTab(),
                  SavedTab(),
                ]),
          );
        },
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    var viewModel=Provider.of<StatusViewModel>(context);
    if(viewModel.isSelectionMode)
      {
        return AppBar(
          actions: <Widget>[
            IconButton(
              tooltip: "Select All",
              iconSize: 32.0,
              icon: Icon(Icons.select_all),
              onPressed: (){
                viewModel.toggleSelectAll();
                if(viewModel.selectAll){
                     viewModel.makeSelectedTrue();
                }
                else if(!viewModel.selectAll && viewModel.countSelected!=viewModel.imageFilesCount) {
                     viewModel.makeSelectedTrue();
                }
                else if(!viewModel.selectAll)
                  {
                     viewModel.makeSelectedFalse();
                     viewModel.toggleSelectionMode();
                  }
              },
            ),
            SizedBox(width: 10.0,),
            Builder(
              builder: (context)=>
                  IconButton(
                    tooltip: "Save",
                    iconSize: 30.0,
                    icon: Icon(Icons.save),
                    onPressed: (){
                        viewModel.saveMultipleImageFiles();
                        //Scaffold.of(context).showSnackBar(kSnackBarForImageSave);
                    },
                  ),
            ),
            SizedBox(width: 5.0,),
            IconButton(
              tooltip: "Share",
              iconSize: 30.0,
              icon: Icon(Icons.share),
              onPressed: (){
                viewModel.shareMultipleImageFiles();
              },
            ),
            SizedBox(width: 10.0,)
          ],
          bottom: TabBar(
            tabs: [
              Tab(text:"Images"),
              Tab(text:"Videos"),
              Tab(text:"Saved"),
            ],
          ),
        );
      }

    return AppBar(
        title: Text("Status Keeper"),
        bottom: TabBar(
          tabs: [
            Tab(text:"Images"),
            Tab(text:"Videos"),
            Tab(text:"Saved"),
          ],
        ),
      );
  }

}