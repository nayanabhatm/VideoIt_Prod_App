import 'package:flutter/material.dart';
import 'package:whatsappstatus/data/status_view_model.dart';
import 'package:provider/provider.dart';
import 'package:whatsappstatus/models/single_image_card.dart';
import 'displayImageScreen.dart';

class ImagesGrid extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    var viewModelImagesData = Provider.of<StatusViewModel>(context , listen: false);
        return GridView.builder(
            gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 1.0,
                  mainAxisSpacing: 1.0,
            ),
            itemCount: viewModelImagesData.imageFilesCount ,
            itemBuilder:(context,index){
              return Container(
                child: GestureDetector(
                  onTap: (){
                    if(!viewModelImagesData.isSelectionMode){
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return DisplayImage(index: index, imageFilePath: viewModelImagesData.imageFiles[index].imagePath,);
                        })
                        );
                    }
                    else {
                      viewModelImagesData.toggleSelected(index);
                    }
                  },
                  onLongPress: () {
                    if(!viewModelImagesData.isSelectionMode)
                            viewModelImagesData.makeSelectedFalse();

                    viewModelImagesData.toggleSelectionMode();
                    viewModelImagesData.toggleSelected(index);
                  },

                  child: Hero(
                    tag: 'index $index',
                    child: ImageCard(
                      imageFile:viewModelImagesData.imageFiles[index],
                    ),
                  ),
                ),
              ) ;
            }
        );
  }
}


