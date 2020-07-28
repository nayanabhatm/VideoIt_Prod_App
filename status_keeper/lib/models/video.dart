class VideoFile{
  final String videoPath;
  bool isSelected;

  VideoFile({this.videoPath,this.isSelected=false});

  void toggleIsSelected(){
    isSelected=!isSelected;
  }

  void makeIsSelectedFalse(){
    isSelected=false;
  }

  void makeIsSelectedTrue(){
    isSelected=true;
  }

}