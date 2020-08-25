/* contains getUser api details*/

class UserProfileDetails{
  String _userName,_userDescription;
  int _followersCount,_followingCount,_videoCount;

  void setUsername(String username){
    _userName=username;
  }

  void setDescription(String description){
    _userDescription=description;
  }

  void setFollowersCount(int followersCount){
    _followersCount=followersCount;
  }

  void setFollowingCount(int followingCount){
    _followingCount=followingCount;
  }

  void setVideoCount(int videoCount){
    _videoCount=videoCount;
  }


  int get videoCount=>_videoCount;
  int get followingCount=>_followingCount;
  int get followersCount => _followersCount;
  String get username =>_userName;
  String get userDescription => _userDescription;

}