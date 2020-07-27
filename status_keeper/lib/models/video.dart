class VideoFile{
  final String videoPath;
  bool isSelected;

  VideoFile({this.videoPath,this.isSelected=false});

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