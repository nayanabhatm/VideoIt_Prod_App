import 'package:flutter/material.dart';
import 'package:statuskeeper/models/status_view_model.dart';
import 'package:provider/provider.dart';
import 'package:statuskeeper/saved_related/single_image_card_saved.dart';
import 'package:statuskeeper/saved_related/displayImageScreen_saved_tab.dart';

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
                  if(!viewModelImagesData.isLongPress){
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return DisplayImageSavedTab(index: index, imageFilePath: viewModelImagesData.imageFilesSavedDir[index].imagePath,);
                    })
                    );
                  }
                  else {
                    viewModelImagesData.toggleIsSelected(index,'savedImages');
                  }
                },
                onLongPress: () {
                  if(!viewModelImagesData.isLongPress)
                    viewModelImagesData.makeIsSelectedFilesFalse('savedImages');

                  viewModelImagesData.toggleisLongPress();
                  viewModelImagesData.toggleIsSelected(index,'savedImages');
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


