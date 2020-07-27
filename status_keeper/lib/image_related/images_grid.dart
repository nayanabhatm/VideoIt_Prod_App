import 'package:flutter/material.dart';
import 'package:statuskeeper/models/status_view_model.dart';
import 'package:provider/provider.dart';
import 'package:statuskeeper/image_related/single_image_card.dart';
import 'package:statuskeeper/screens/displayImageScreen.dart';

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
                    if(!viewModelImagesData.isSelectionModeImagesTab){
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return DisplayImage(index: index, imageFilePath: viewModelImagesData.imageFilesWhatsAppDir[index].imagePath,);
                        })
                        );
                    }
                    else {
                      viewModelImagesData.toggleSelectedFile(index,'images');
                    }
                  },
                  onLongPress: () {
                    if(!viewModelImagesData.isSelectionModeImagesTab)
                            viewModelImagesData.makeSelectedFilesFalse('images');

                    viewModelImagesData.toggleSelectionModel('images');
                    viewModelImagesData.toggleSelectedFile(index,'images');
                  },

                  child: Hero(
                    tag: 'index$index',
                    child: ImageCard(
                      imageFile:viewModelImagesData.imageFilesWhatsAppDir[index],
                    ),
                  ),
                ),
              ) ;
            }
        );
  }
}


