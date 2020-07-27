import 'package:flutter/material.dart';
import 'package:statuskeeper/models/status_view_model.dart';
import 'package:provider/provider.dart';
import 'package:statuskeeper/saved_related/single_image_card_saved.dart';
import 'package:statuskeeper/screens/displayImageScreen.dart';

class ImagesGridSavedTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var viewModelImagesData = Provider.of<StatusViewModel>(context , listen: false);
    return
       GridView.builder(
          gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 1.0,
            mainAxisSpacing: 1.0,
          ),
          itemCount: viewModelImagesData.imageFilesSavedDirCount ,
          itemBuilder:(context,index){
            return Container(
              child: GestureDetector(
                onTap: (){
                  if(!viewModelImagesData.isSelectionModeSavedImagesTab){
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return DisplayImage(index: index, imageFilePath: viewModelImagesData.imageFilesSavedDir[index].imagePath,);
                    })
                    );
                  }
                  else {
                    viewModelImagesData.toggleSelectedFile(index,'savedImages');
                  }
                },
                onLongPress: () {
                  if(!viewModelImagesData.isSelectionModeSavedImagesTab)
                    viewModelImagesData.makeSelectedFilesFalse('savedImages');

                  viewModelImagesData.toggleSelectionModel('savedImages');
                  viewModelImagesData.toggleSelectedFile(index,'savedImages');
                },

                child: Hero(
                  tag: 'index$index',
                  child: ImageCardSaved(
                    imageFile:viewModelImagesData.imageFilesSavedDir[index],
                  ),
                ),
              ),
            ) ;
          }
      );
  }
}


