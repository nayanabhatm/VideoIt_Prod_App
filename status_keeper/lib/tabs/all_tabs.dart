import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statuskeeper/models/status_view_model.dart';
import 'package:statuskeeper/functionalities/checkStoragePermission.dart';
import 'package:statuskeeper/image_related/images_grid.dart';
import 'package:statuskeeper/saved_related/saved_tab.dart';
import 'package:statuskeeper/videos_related/videos_grid.dart';
import 'package:statuskeeper/buildAppBar.dart';


class Tabs extends StatefulWidget {
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> with WidgetsBindingObserver, AutomaticKeepAliveClientMixin{

  int currentTab,previousTab;
  
  
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
        viewModelData.makeSelectionModeLongPressFalse();
        setState(() {
          currentTab=tabController.index;
          previousTab=tabController.previousIndex;
        });
      });

      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          viewModelData.makeIsSelectAllFalse();
          viewModelData.makeSelectionModeLongPressFalse();

        ['images','videos','savedImages','savedVideos'].forEach((element) {
          viewModelData.makeIsSelectedFilesFalse(element);
          viewModelData.clearFilesList(element);
          viewModelData.addFilesToList(element);
        });


      });

    });


  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
    var viewModelData=Provider.of<StatusViewModel>(context,listen: false);
    if(state==AppLifecycleState.resumed)
    {
      viewModelData.makeIsSelectAllFalse();
      viewModelData.makeSelectionModeLongPressFalse();

      ['images','videos','savedImages','savedVideos'].forEach((element) {
        viewModelData.makeIsSelectedFilesFalse(element);
        viewModelData.clearFilesList(element);
        viewModelData.addFilesToList(element);
      });

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
        if(viewModelData.isLongPress ) {
            viewModelData.makeSelectionModeLongPressFalse();
            return Future<bool>.value(false);
         }
        else{
          return Future<bool>.value(true);
        }
      },
      child: Builder(
        builder: (context){
          return Scaffold(
            appBar: AppBarBuild().buildAppBar(context,currentTab,previousTab),
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



}