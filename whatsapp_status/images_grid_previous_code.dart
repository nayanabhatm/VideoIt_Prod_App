import 'package:flutter/material.dart';
import 'package:whatsappstatus/data/status_view_model.dart';
import 'package:provider/provider.dart';
import 'package:whatsappstatus/models/single_image_card.dart';
import 'displayImageScreen.dart';

class ImagesGrid extends StatelessWidget {
  final StatusViewModel imagesData=StatusViewModel();

  @override
  Widget build(BuildContext context) {
    return Consumer<StatusViewModel>(
      builder: (context,imagesData,child){
        return GridView.builder(
            gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 1.0,
              mainAxisSpacing: 1.0,
            ),
            itemCount: buildImageCard(imagesData).imageFilesCount ,
            itemBuilder:(context,index){
              return Container(
                child: GestureDetector(
                  onTap: (){
                    if(!buildImageCard(imagesData).isSelectionMode){
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return DisplayImage(index: index, imageFilePath: buildImageCard(imagesData).imageFiles[index].imagePath,);
                      }));
                    }
                    else {
                      //imagesData.toggleSelected(index);
                    }
                  },
                  onLongPress: (){
                    buildImageCard(imagesData).toggleSelected(index);
                    buildImageCard(imagesData).toggleSelectionMode();
                  },

                  child: Hero(
                    tag: 'index$index',
                    child: ImageCard(
                      imageFile: buildImageCard(imagesData).imageFiles[index],
                    ) ,
                  ),
                ),
              ) ;
            }
        );
      },
    );
  }

  StatusViewModel buildImageCard(StatusViewModel imagesData) => imagesData;

}


