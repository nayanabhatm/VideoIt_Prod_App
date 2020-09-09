import 'package:json_annotation/json_annotation.dart';

part "service_api_response_models.g.dart";

@JsonSerializable()
class LoginResponse {
  List<String> permission;
  String uuid;
  String session;
  String username;

  LoginResponse({this.permission, this.uuid, this.session, this.username});

  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);

}


@JsonSerializable()
class UserProfileDetails{
  String userName;
  int lastLogginTime;
  int videoCount;
  int followersCount;
  int followingCount;
  bool accountVerified;

  UserProfileDetails({this.userName, this.lastLogginTime, this.videoCount,this.followersCount, this.followingCount, this.accountVerified});

  factory UserProfileDetails.fromJson(Map<String, dynamic> json) => _$UserProfileDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$UserProfileDetailsToJson(this);
}



@JsonSerializable()
class VideoDetails{
  String videoId;
  String uuid;
  int views;
  int likes;
  int addedDate;
  int updatedDate;
  String description;
  String inheritedFrom;
  bool blocked;

  VideoDetails({this.videoId,this.uuid, this.views, this.likes, this.addedDate, this.updatedDate, this.description,
    this.inheritedFrom, this.blocked});

  factory VideoDetails.fromJson(Map<String,dynamic> json) => _$VideoDetailsFromJson(json);
  Map<String,dynamic> toJson() => _$VideoDetailsToJson(this);

}

@JsonSerializable()
class VideoStreamUrl{
  String url;

  VideoStreamUrl({this.url});

  factory VideoStreamUrl.fromJson(Map<String,dynamic> json) => _$VideoStreamUrlFromJson(json);
  Map<String,dynamic> toJson() => _$VideoStreamUrlToJson(this);

}