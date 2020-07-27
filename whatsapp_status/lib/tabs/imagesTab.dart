import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsappstatus/data/status_view_model.dart';
import 'package:whatsappstatus/models/images_grid.dart';
import 'package:provider/provider.dart';
import 'package:whatsappstatus/models/checkStoragePermission.dart';


class ImagesTab extends StatefulWidget {
  @override
  _ImagesTabState createState() => _ImagesTabState();
}

class _ImagesTabState extends State<ImagesTab> with WidgetsBindingObserver{

      @override
      void initState() {
        print("init");
        super.initState();
        var viewModelImagesData=Provider.of<StatusViewModel>(context,listen: false);
        WidgetsBinding.instance.addObserver(this);
        PermissionCheck().checkStoragePermission();
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            viewModelImagesData.makeSelectAllFalse();
            viewModelImagesData.makeSelectionModeFalse();
            viewModelImagesData.makeSelectedFalse();
            viewModelImagesData.clearImageFilesList();
            viewModelImagesData.addImagesToImagesList();
        });
      }

      @override
      void didChangeAppLifecycleState(AppLifecycleState state) {
        print(state);
        var viewModelImagesData=Provider.of<StatusViewModel>(context,listen: false);
        if(state==AppLifecycleState.paused || state==AppLifecycleState.resumed || state==AppLifecycleState.inactive)
        {
            viewModelImagesData.makeSelectAllFalse();
            viewModelImagesData.makeSelectionModeFalse();
            viewModelImagesData.makeSelectedFalse();
            viewModelImagesData.clearImageFilesList();
            viewModelImagesData.addImagesToImagesList();
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
        return ImagesGrid();
      }
}
