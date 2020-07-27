import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statuskeeper/models/status_view_model.dart';
import 'package:statuskeeper/constants.dart';
import 'package:statuskeeper/functionalities/checkStoragePermission.dart';
import 'package:statuskeeper/image_related/images_grid.dart';
import 'package:statuskeeper/saved_related/saved_tab.dart';
import 'package:statuskeeper/videos_related/videos_grid.dart';


class Tabs extends StatefulWidget {
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> with WidgetsBindingObserver, AutomaticKeepAliveClientMixin{

  int currentTab;
  
  
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    print("intit");
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var viewModelData=Provider.of<StatusViewModel>(context,listen: false);
      WidgetsBinding.instance.addObserver(this);
      PermissionCheck().checkStoragePermission();

      var tabController = DefaultTabController.of(context);
      tabController.addListener(() {
        currentTab=tabController.index;
        setState(() {

        });
      });

      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        viewModelData.makeSelectAllFalse();

        ['images','videos','savedImages','savedVideos'].forEach((element) {
          viewModelData.makeSelectionModeFalse(element);
          viewModelData.makeSelectedFilesFalse(element);
        });

        viewModelData.makeSelectionModeFalse('images');
        viewModelData.makeSelectionModeFalse('videos');
        viewModelData.makeSelectionModeFalse('savedImages');
        viewModelData.makeSelectionModeFalse('savedVideos');

        viewModelData.makeSelectedFilesFalse('images');
        viewModelData.makeSelectedFilesFalse('videos');
        viewModelData.makeSelectedFilesFalse('savedImages');
        viewModelData.makeSelectedFilesFalse('savedVideos');

        viewModelData.clearFilesList('images');
        viewModelData.clearFilesList('videos');
        viewModelData.clearFilesList('savedImages');
        viewModelData.clearFilesList('savedVideos');

        viewModelData.addFilesToList('images');
        viewModelData.addFilesToList('videos');
        viewModelData.addFilesToList('savedImages');
        viewModelData.addFilesToList('savedVideos');
      });

    });


  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
    var viewModelData=Provider.of<StatusViewModel>(context,listen: false);
    var currentTab=DefaultTabController.of(context).index;
    if(state==AppLifecycleState.resumed)
    {
      viewModelData.makeSelectAllFalse();

      viewModelData.makeSelectionModeFalse('images');
      viewModelData.makeSelectionModeFalse('videos');
      viewModelData.makeSelectionModeFalse('savedImages');
      viewModelData.makeSelectionModeFalse('savedVideos');


      viewModelData.makeSelectedFilesFalse('images');
      viewModelData.clearFilesList('images');
      viewModelData.addFilesToList('images');


      viewModelData.makeSelectedFilesFalse('videos');
      viewModelData.clearFilesList('videos');
      viewModelData.addFilesToList('videos');

      viewModelData.makeSelectedFilesFalse('savedImages');
      viewModelData.clearFilesList('savedImages');
      viewModelData.addFilesToList('savedImages');

        viewModelData.makeSelectedFilesFalse('savedVideos');
        viewModelData.clearFilesList('savedVideos');
        viewModelData.addFilesToList('savedVideos');

    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    super.build(context);
    return WillPopScope(
      onWillPop: (){
        var viewModelData=Provider.of<StatusViewModel>(context,listen: false);
        if(viewModelData.isSelectionModeVideosTab ) {
            viewModelData.makeSelectionModeFalse('videos');
            return Future<bool>.value(false);
         }
        else if(viewModelData.isSelectionModeImagesTab){
          viewModelData.makeSelectionModeFalse('images');
          return Future<bool>.value(false);
        }
        else if(viewModelData.isSelectionModeSavedVideosTab ) {
          viewModelData.makeSelectionModeFalse('savedVideos');
          return Future<bool>.value(false);
        }
        else if(viewModelData.isSelectionModeSavedImagesTab){
          viewModelData.makeSelectionModeFalse('savedImages');
          return Future<bool>.value(false);
        }
        else{
          return Future<bool>.value(true);
        }
      },
      child: Builder(
        builder: (context){
          return Scaffold(
            appBar: buildAppBar(context),
            body: TabBarView(
                children: [
                  ImagesGrid(),
                  VideosGrid(),
                  SavedTab(),
                ]),
          );
        },
      ),
    );
  }


  AppBar buildAppBar(BuildContext context) {
    var viewModel=Provider.of<StatusViewModel>(context);
    print("......currenttab $currentTab");
    if(viewModel.isSelectionModeImagesTab || viewModel.isSelectionModeVideosTab)
    {
      return AppBar(
        actions: <Widget>[
          IconButton(
            tooltip: "Select All",
            iconSize: 32.0,
            icon: Icon(Icons.select_all),
            onPressed: (){
              if(currentTab==0){
                  viewModel.toggleSelectAll();
                  if(viewModel.selectAll){
                    viewModel.makeSelectedFilesTrue('images');
                  }
                  else if(!viewModel.selectAll && viewModel.countOfFilesSelected('images')!=viewModel.imageFilesCount) {
                    viewModel.makeSelectedFilesTrue('images');
                  }
                  else if(!viewModel.selectAll)
                  {
                    viewModel.makeSelectedFilesFalse('images');
                    viewModel.toggleSelectionModel('images');
                  }
              }
              else if(currentTab==1){
                  viewModel.toggleSelectAll();
                  if(viewModel.selectAll){
                    viewModel.makeSelectedFilesTrue('videos');
                  }
                  else if(!viewModel.selectAll && viewModel.countOfFilesSelected('videos')!=viewModel.videoFilesCount) {
                    viewModel.makeSelectedFilesTrue('videos');
                  }
                  else if(!viewModel.selectAll)
                  {
                    viewModel.makeSelectedFilesFalse('videos');
                    viewModel.toggleSelectionModel('videos');
                  }
              }
              else if(currentTab==2){
                viewModel.toggleSelectAll();
                if(viewModel.selectAll){
                  viewModel.makeSelectedFilesTrue('savedImages');
                  viewModel.makeSelectedFilesTrue('savedVideos');
                }
                else if((!viewModel.selectAll && viewModel.countOfFilesSelected('savedImages')!=viewModel.imageFilesSavedDirCount) ||
                    (!viewModel.selectAll && viewModel.countOfFilesSelected('savedVideos')!=viewModel.videoFilesSavedDirCount)) {
                    viewModel.makeSelectedFilesTrue('savedImages');
                    viewModel.makeSelectedFilesTrue('savedVideos');
                }
                else if(!viewModel.selectAll)
                {
                  viewModel.makeSelectedFilesFalse('savedImages');
                  viewModel.toggleSelectionModel('savedVideos');
                }
              }
            },
          ),
          SizedBox(width: 10.0,),
          Builder(
            builder: (context){
              return IconButton(
                tooltip: "Save",
                iconSize: 30.0,
                icon: Icon(Icons.save),
                onPressed: (){
                  if(currentTab==0){
                    viewModel.saveMultipleFiles('images');
                    Scaffold.of(context).showSnackBar(kSnackBarForSaved);
                    viewModel.toggleSelectionModel('images');
                  }
                  else if(currentTab==1){
                    viewModel.saveMultipleFiles('videos');
                    Scaffold.of(context).showSnackBar(kSnackBarForSaved);
                    viewModel.toggleSelectionModel('videos');
                  }
                },
              );
            }
          ),
          SizedBox(width: 5.0,),
          IconButton(
            tooltip: "Share",
            iconSize: 30.0,
            icon: Icon(Icons.share),
            onPressed: (){
              if(currentTab==0)
                viewModel.shareMultipleFiles('images');
              else if(currentTab==1)
                viewModel.shareMultipleFiles('videos');
              else if(currentTab==2){
                viewModel.shareMultipleFiles('savedImages');
                viewModel.shareMultipleFiles('savedVideos');
              }
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
    else if(viewModel.isSelectionModeSavedImagesTab || viewModel.isSelectionModeSavedVideosTab)
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
                  if(viewModel.toggleButtonImage){
                      viewModel.makeSelectedFilesTrue('savedImages');
                  }
                  else if(viewModel.toggleButtonVideo) {
                    viewModel.makeSelectedFilesTrue('savedVideos');
                  }
                }
                else if(viewModel.toggleButtonImage && !viewModel.selectAll && viewModel.countOfFilesSelected('savedImages')!=viewModel.imageFilesSavedDirCount)
                {
                  viewModel.makeSelectedFilesTrue('savedImages');
                }
                else if(viewModel.toggleButtonVideo && !viewModel.selectAll && viewModel.countOfFilesSelected('savedVideos')!=viewModel.videoFilesSavedDirCount)
                {
                  viewModel.makeSelectedFilesTrue('savedVideos');
                }

                else if(!viewModel.selectAll)
                {
                  if(viewModel.toggleButtonImage){
                    viewModel.makeSelectedFilesFalse('savedImages');
                  }
                  else if(viewModel.toggleButtonVideo){
                    viewModel.toggleSelectionModel('savedVideos');
                  }
                }
            },
          ),
          SizedBox(width: 10.0,),
          IconButton(
            tooltip: "Delete",
            iconSize: 30.0,
            icon: Icon(Icons.delete),
            onPressed: (){
                viewModel.deleteMultipleFiles('savedImages');
                Scaffold.of(context).showSnackBar(kSnackBarForDelete);
                viewModel.toggleSelectionModel('savedImages');

                viewModel.deleteMultipleFiles('savedVideos');
                Scaffold.of(context).showSnackBar(kSnackBarForDelete);
                viewModel.toggleSelectionModel('savedVideos');
            },
          ),
          SizedBox(width: 5.0,),
          IconButton(
            tooltip: "Share",
            iconSize: 30.0,
            icon: Icon(Icons.share),
            onPressed: (){
              if(currentTab==0)
                viewModel.shareMultipleFiles('images');
              else if(currentTab==1)
                viewModel.shareMultipleFiles('videos');
              else if(currentTab==2){
                viewModel.shareMultipleFiles('savedImages');
                viewModel.shareMultipleFiles('savedVideos');
              }
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