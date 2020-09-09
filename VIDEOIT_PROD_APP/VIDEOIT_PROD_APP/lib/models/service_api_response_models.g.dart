// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_api_response_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) {
  return LoginResponse(
    permission: (json['permission'] as List)?.map((e) => e as String)?.toList(),
    uuid: json['uuid'] as String,
    session: json['session'] as String,
    username: json['username'] as String,
  );
}

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'permission': instance.permission,
      'uuid': instance.uuid,
      'session': instance.session,
      'username': instance.username,
    };

UserProfileDetails _$UserProfileDetailsFromJson(Map<String, dynamic> json) {
  return UserProfileDetails(
    userName: json['userName'] as String,
    lastLogginTime: json['lastLogginTime'] as int,
    videoCount: json['videoCount'] as int,
    followersCount: json['followersCount'] as int,
    followingCount: json['followingCount'] as int,
    accountVerified: json['accountVerified'] as bool,
  );
}

Map<String, dynamic> _$UserProfileDetailsToJson(UserProfileDetails instance) =>
    <String, dynamic>{
      'userName': instance.userName,
      'lastLogginTime': instance.lastLogginTime,
      'videoCount': instance.videoCount,
      'followersCount': instance.followersCount,
      'followingCount': instance.followingCount,
      'accountVerified': instance.accountVerified,
    };

VideoDetails _$VideoDetailsFromJson(Map<String, dynamic> json) {
  return VideoDetails(
    videoId: json['videoId'] as String,
    uuid: json['uuid'] as String,
    views: json['views'] as int,
    likes: json['likes'] as int,
    addedDate: json['addedDate'] as int,
    updatedDate: json['updatedDate'] as int,
    description: json['description'] as String,
    inheritedFrom: json['inheritedFrom'] as String,
    blocked: json['blocked'] as bool,
  );
}

Map<String, dynamic> _$VideoDetailsToJson(VideoDetails instance) =>
    <String, dynamic>{
      'videoId': instance.videoId,
      'uuid': instance.uuid,
      'views': instance.views,
      'likes': instance.likes,
      'addedDate': instance.addedDate,
      'updatedDate': instance.updatedDate,
      'description': instance.description,
      'inheritedFrom': instance.inheritedFrom,
      'blocked': instance.blocked,
    };

VideoStreamUrl _$VideoStreamUrlFromJson(Map<String, dynamic> json) {
  return VideoStreamUrl(
    url: json['url'] as String,
  );
}

Map<String, dynamic> _$VideoStreamUrlToJson(VideoStreamUrl instance) =>
    <String, dynamic>{
      'url': instance.url,
    };
