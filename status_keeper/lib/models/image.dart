class ImageFile{
  final String imagePath;
  bool isSelected;

  ImageFile({this.imagePath,this.isSelected=false});

  void toggleSelected(){
    isSelected=!isSelected;
  }

  void makeSelectedFalse(){
    isSelected=false;
  }

  void makeSelectedTrue(){
    isSelected=true;
  }
}