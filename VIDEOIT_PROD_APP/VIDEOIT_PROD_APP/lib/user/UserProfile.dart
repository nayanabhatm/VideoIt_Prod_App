/* contains getUser api details*/

class UserProfileDetails{
  final String userName,userDescription;
  final int followersCount,followingCount,videoCount;

  UserProfileDetails({this.userName,this.userDescription,this.followersCount,this.followingCount,this.videoCount});

  factory UserProfileDetails.fromJson(Map<String,dynamic> jsonResponse){
    return UserProfileDetails(
        userName:jsonResponse['userName'],
        userDescription:jsonResponse['userDescription'],
        followersCount:jsonResponse['followersCount'],
        followingCount:jsonResponse['followingCount'],
        videoCount:jsonResponse['videoCount'],
    );
  }




}