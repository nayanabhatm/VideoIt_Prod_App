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
            itemCount: viewModelImagesData.imageFilesWhatsappDirCount ,
            itemBuilder:(context,index){
              return Container(
                child: GestureDetector(
                  onTap: (){
                    if(!viewModelImagesData.isLongPress){
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return DisplayImage(index: index, imageFilePath: viewModelImagesData.imageFilesWhatsAppDir[index].imagePath,);
                        })
                        );
                    }
                    else {
                      viewModelImagesData.toggleIsSelected(index,'images');
                    }
                  },
                  onLongPress: () {
                    if(!viewModelImagesData.isLongPress)
                            viewModelImagesData.makeIsSelectedFilesFalse('images');

                    viewModelImagesData.toggleisLongPress();
                    viewModelImagesData.toggleIsSelected(index,'images');
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


