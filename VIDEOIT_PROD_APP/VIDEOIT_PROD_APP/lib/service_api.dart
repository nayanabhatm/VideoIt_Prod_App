import 'dart:developer';
import 'dart:io';

import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:videoit/constants/Constants.dart';
import 'package:videoit/pages/profile/UserProfilePage.dart';
import 'package:videoit/service_api_calls.dart';
import 'package:videoit/models/service_api_response_models.dart';
import 'dart:convert' as convert;
import 'package:videoit/user/User.dart';
import 'package:videoit/user/UserProfile.dart';


final dio = Dio();
final client = RestClient(dio);

class ServiceAPI{
  static final ServiceAPI _serviceAPI =ServiceAPI._internal() ;
  factory ServiceAPI(){
    return _serviceAPI;
  }
  ServiceAPI._internal();

  LoginResponse _loginResponse;
  UserProfileDetails _userProfileDetails;
  List<VideoDetails> _userVideosDetails;
  VideoDetails _singleVideoDetails;
  VideoStreamUrl _videoStreamUrl;

  String get username => _loginResponse.username;
  String get session => _loginResponse.session;
  String get uuid => _loginResponse.uuid;

  //int get lengthOfListOfVideos => _userVideosDetails.length;


  Future<String> signUp(String idToken,String googleEmail) async {
        try{
          Map body={"authProvider":"GOAuth","authToken":"$idToken"};
          await client.signUp(body);
          String res=await login(idToken,googleEmail);
          return res;
        }
        catch(e){
          print(e);
          return 'Error';
        }
  }


  Future<String> login(String idToken,String googleEmail) async {
        try {
          String username = (googleEmail).replaceFirst(RegExp(r'@gmail.com'), '');
          String basicAuth = 'Basic ' +convert.base64Encode(convert.utf8.encode('$username:$idToken'));
          _loginResponse=await client.login(basicAuth);
          print(_loginResponse);
          return _loginResponse.username;
        }
        catch(e){
          print(e);
          return 'Error';
        }

  }

  Future<UserProfileDetails> getUser() async{
      try{
        _userProfileDetails=await client.getUser(session,uuid,username);
        print("uesrresponese: ${_userProfileDetails.videoCount} ${_userProfileDetails.userName}");
        return _userProfileDetails;
      }
      catch(e){
        print(e);
      }

  }

//  static Future incrementFollow() async{
//        try{
//          String url= kIPAddress+'/session/follow';
//          Map<String,String> headers= {'Content-Type':'application/json','VI_SESSION':'${User.session}','VI_UID':'${User.uuid}'};
//          String body='{"userName":"${User.username}"}';
//
//          Response followResponse=await dio.post(
//            url,
//            options: Options(headers: headers),
//            data: body,
//          );
//        }
//        catch(e){
//          print(e);
//        }
//
//
//  }
//
//  static Future uploadVideo(String videoFilePath) async{
////    String fileName="/storage/emulated/0/Status Keeper/VID-20181022-WA0000-1.mp4";
//    File videoFile=File(videoFilePath);
//    final thumbnailFile = await VideoThumbnail.thumbnailData(
//      video: videoFilePath,
//      imageFormat: ImageFormat.JPEG,
//      maxWidth: 128, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
//      quality: 25,
//    );
//    try{
//      String url=kIPAddress+'/content/management/upload';
//      String body='{"file":$videoFile,"uuid":"${User.uuid}","videoDescription":"Description","thumbnail":$thumbnailFile,"refernceVideoId":"self"}';
//      Map<String,String> headers= {'Content-Type':'application/json','VI_SESSION':'${User.session}','VI_UID':'${User.uuid}'};
//
//      Response uploadVideoResponse=await dio.post(
//        url,
//        options: Options(headers: headers),
//        data: body,
//      );
//
//      print("Upload video status code: ${uploadVideoResponse.statusCode}");
//    }
//    catch(e){
//      print(e);
//    }
//  }
//
//  static Future getThumbnail(String videoId) async {
//    try{
//       String url=kIPAddress+'/content/management/video/getThumbnail/'+videoId;
//       Map<String,String> headers= {'Content-Type':'application/json','VI_SESSION':'${User.session}','VI_UID':'${User.uuid}'};
//
//       Response getThumbnailResponse=await dio.get(
//         url,
//         options: Options(headers: headers),
//       );
//
//       print("getthumbnail response: ${getThumbnailResponse.statusCode}");
//    }
//    catch(e){
//      print(e);
//    }
//
//  }

  Future<List<VideoDetails>> getUserVideos() async{
    int batchNumber=1;

    try{
      _userVideosDetails=await client.getUserVideos(session, uuid,uuid, batchNumber);
      print("uservideodetails:$_userVideosDetails");
      return _userVideosDetails;
    }
    catch(e){
      print(e);
    }
  }


//  Future streamURL() async{
//    try{
//      _videoStreamUrl=await client.getVideoStreamUrl(session,uuid,videoId).catchError((Object obj){
//        final errorResponse=(obj as DioError).response;
//        print("Got error : ${errorResponse.statusCode} -> ${errorResponse.statusMessage}");
//      });
//      print(_videoStreamUrl);
//    }
//    catch(e){
//      print(e);
//    }
//  }


}