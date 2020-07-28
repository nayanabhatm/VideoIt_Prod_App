import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statuskeeper/models/status_view_model.dart';
import 'package:statuskeeper/constants.dart';

class AppBarBuild {
  AppBar buildAppBar(BuildContext context, int currentTab,int previousTab) {
    var viewModel = Provider.of<StatusViewModel>(context);
    print("$currentTab, ......$previousTab");
    if (viewModel.isLongPress) {
        if (currentTab == 0 || currentTab == 1)
        {
            return AppBar(
              actions: <Widget>[
                IconButton(
                  tooltip: "Select All",
                  iconSize: 32.0,
                  icon: Icon(Icons.select_all),
                  onPressed: () {
                    if (currentTab == 0) {
                       viewModel.isSelectAllButtonFunctionality('images');
                    }
                    else if (currentTab == 1) {
                       viewModel.isSelectAllButtonFunctionality('videos');
                    }
                  },
                ),
                SizedBox(width: 10.0,),
                Builder(
                    builder: (context) {
                      return IconButton(
                        tooltip: "Save",
                        iconSize: 30.0,
                        icon: Icon(Icons.save),
                        onPressed: () {
                          if (currentTab == 0) {
                            viewModel.saveMultipleFiles('images');
                            Scaffold.of(context).showSnackBar(kSnackBarForSaved);
                          }
                          else if (currentTab == 1) {
                            viewModel.saveMultipleFiles('videos');
                            Scaffold.of(context).showSnackBar(kSnackBarForSaved);
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
                  onPressed: () {
                    if (currentTab == 0)
                      viewModel.shareMultipleFiles('images');
                    else if (currentTab == 1)
                      viewModel.shareMultipleFiles('videos');
                    else if (currentTab == 2) {
                      viewModel.shareMultipleFiles('savedImages');
                      viewModel.shareMultipleFiles('savedVideos');
                    }
                  },
                ),
                SizedBox(width: 10.0,)
              ],
              bottom: TabBar(
                tabs: [
                  Tab(text: "Images"),
                  Tab(text: "Videos"),
                  Tab(text: "Saved"),
                ],
              ),
            );
        }
        else if (currentTab == 2) {
          return AppBar(
              actions: <Widget>[
                IconButton(
                  tooltip: "Select All",
                  iconSize: 32.0,
                  icon: Icon(Icons.select_all),
                  onPressed: () {
                    if(viewModel.savedTabToggleButtonImage)
                      viewModel.isSelectAllButtonFunctionality('savedImages');
                    else if(viewModel.savedTabToggleButtonVideo)
                      viewModel.isSelectAllButtonFunctionality('savedVideos');
                  },
                ),
                SizedBox(width: 10.0,),
                Builder(
                  builder: (context){
                    return IconButton(
                      tooltip: "Delete",
                      iconSize: 30.0,
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        if(viewModel.savedTabToggleButtonImage) {
                          viewModel.deleteMultipleFiles('savedImages');
                          Scaffold.of(context).showSnackBar(kSnackBarForDelete);
                        }
                        else if(viewModel.savedTabToggleButtonVideo) {
                          viewModel.deleteMultipleFiles('savedVideos');
                          Scaffold.of(context).showSnackBar(kSnackBarForDelete);
                        }
                      },
                    );
                  },
                ),
                SizedBox(width: 5.0,),
                IconButton(
                  tooltip: "Share",
                  iconSize: 30.0,
                  icon: Icon(Icons.share),
                  onPressed: () {
                    if(viewModel.savedTabToggleButtonImage){
                      viewModel.shareMultipleFiles('savedImages');}
                    else if (viewModel.savedTabToggleButtonVideo){
                      viewModel.shareMultipleFiles('savedVideos');}
                  },
                ),
                SizedBox(width: 10.0,)
              ],
              bottom: TabBar(
                tabs: [
                  Tab(text: "Images"),
                  Tab(text: "Videos"),
                  Tab(text: "Saved"),
                ],
              ),
            );
         }
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