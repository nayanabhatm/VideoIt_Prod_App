import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:videoit/constants/Constants.dart';
import 'dart:convert' as convert;
import 'package:videoit/user/User.dart';
import 'package:videoit/user/UserProfile.dart';

class APICalls{
  static Dio dio=Dio();

  static Future signUpWithVideoIt(String idToken,String googleEmail) async {
        try{
          String url=kIPAddress+"/signup/";
          Map<String,String> headers= {"Content-Type":"application/json"};
          String body='{"authProvider":"GOAuth","authToken":"$idToken"}';

          Response signupResponse=await dio.post( url,
            options: Options(headers: headers),
            data: body,
          );
          log("singuprequest: $url,$headers,$body");
          print("signupresonse:${signupResponse.statusMessage}");
          await loginToVideoIt(idToken,googleEmail);
        }
        catch(e){
          print(e);
        }
  }

  static Future loginToVideoIt(String idToken,String googleEmail) async {
    print("logintovideoit");
        try {
          String url = kIPAddress + "/login/";
          String username = (googleEmail).replaceFirst(RegExp(r'@gmail.com'), '');
          String basicAuth = 'Basic ' +convert.base64Encode(convert.utf8.encode('$username:$idToken'));
          Map<String, String> headers = {
            'AUTH_PROVIDER': 'GOAuth',
            'Content-Type': 'application/json',
            'authorization': '$basicAuth'
          };

          log("LOGINLOGIN: $url, $headers");

          Response loginResponse = await dio.post(url,
            options: Options(headers: headers),
          );

          print("LOGINresponse:$loginResponse");

          User.setUserName(loginResponse.data['username']);
          User.setSession(loginResponse.data['session']);
          User.setUuid(loginResponse.data['uuid']);
          User.setUserPermission(loginResponse.data['permission']);
        }
        catch(e){
          print(e);
        }

  }

  static Future<UserProfileDetails> getUser() async{
      UserProfileDetails userProfile=UserProfileDetails();

      try{
        String url=kIPAddress+"/session/getUser/${User.username}";
        Map<String,String> headers= {'Content-Type':'application/json','VI_SESSION':'${User.session}','VI_UID':'${User.uuid}'};
        Response getUserResponse=await dio.get(
            url,
            options: Options(
              headers: headers,
            )
        );

        print("getuser response: $getUserResponse");
        userProfile.setUsername(getUserResponse.data['userName']);
        userProfile.setDescription(getUserResponse.data['description']);
        userProfile.setFollowersCount(getUserResponse.data['followersCount']);
        userProfile.setFollowingCount(getUserResponse.data['followingCount']);
        userProfile.setVideoCount(getUserResponse.data['videoCount']);

        return userProfile;
      }
      catch(e){
        print(e);
        return null;
      }

  }

  static Future incrementFollow() async{
        try{
          String url= kIPAddress+'/session/follow';
          Map<String,String> headers= {'Content-Type':'application/json','VI_SESSION':'${User.session}','VI_UID':'${User.uuid}'};
          String body='{"userName":"${User.username}"}';

          Response followResponse=await dio.post(
            url,
            options: Options(headers: headers),
            data: body,
          );
        }
        catch(e){
          print(e);
        }
        
    
  }


}