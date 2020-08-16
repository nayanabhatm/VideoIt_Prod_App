import 'dart:developer';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:videoit/constants/Constants.dart';
import 'package:videoit/user/UserInformation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:videoit/user/User.dart';

class Auth{
  static GoogleSignIn googleSignIn = GoogleSignIn(clientId: kclientId);
  static UserInformation userInformation = UserInformation();
  static GoogleSignInAccount googleUser;
  static GoogleSignInAccount account;
  static GoogleSignInAuthentication authentication;

  static Future<String> loginWithGoogle() async {
    await googleSignIn.signOut();
    googleUser = await googleSignIn.signIn();
    if(googleUser != null) {
      account = googleSignIn.currentUser;
      authentication = await account.authentication;

      //update userinformation object with the response from google authentication
      userInformation.setEmailId(account.email);
      userInformation.setUsername(account.displayName);
      userInformation.setToken(authentication.idToken);

      log(authentication.idToken);

      // login to VideoIt server
      final String url="http://192.168.0.102:8999/login/";
      String username= (account.email).replaceFirst(RegExp(r'@gmail.com'),'');
      String basicAuth ='Basic '+ convert.base64Encode(convert.utf8.encode('$username:${authentication.idToken}'));
      Map<String,String> requestHeaders= {'AUTH_PROVIDER':'GOAuth','Content-Type':'application/json','authorization':'$basicAuth'};
      final loginResponse= await http.post(url,headers: requestHeaders);
      var jsonResponse = convert.jsonDecode(loginResponse.body);

      //update details in User object
      print("jsonResponse....$jsonResponse");
      //User.setUserPermission(jsonResponse['permission']);
      User.setUuid(jsonResponse['uuid']);
      User.setSession(jsonResponse['session']);
      User.setUserName(jsonResponse['username']);

      print("sessionid: ..${jsonResponse['session']}");
      return('success');
    }
    else {
      return('fail');
    }
  }

//  Future<String> signUpWithGoogle() async {
//    String loginReturnVal=await loginWithGoogle();
//    if(loginReturnVal=='success')
//       {
//         final String url="http://192.168.0.105:8999/signup/";
//         String body='{"authProvider":"GOAuth","authToken":"${authentication.idToken}"}';
//         Map<String,String> requestHeaders= {'Content-Type':'application/json'};
//         final response= await http.post(url,body:body,headers: requestHeaders);
//         log("...........statuscode: ${response.statusCode}>>>>>>>>>>>>>>>body: ${response.body}");
//
//
//
//         return('success');
//       }
//    else{
//      return('fail');
//    }


//  }


  static Future<void> logoutWithGoogle() async {
    await googleSignIn.signOut();
  }
}