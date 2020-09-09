import 'dart:developer';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:videoit/service_api.dart';
import 'package:videoit/constants/Constants.dart';

class GoogleAuthentication{

  static final GoogleAuthentication _googleAuthentication=GoogleAuthentication._internal() ;
  factory GoogleAuthentication() {
    return _googleAuthentication;
  }
  GoogleAuthentication._internal();

  static GoogleSignIn googleSignIn = GoogleSignIn(clientId: kclientId);
  static GoogleSignInAccount googleUser;
  static GoogleSignInAccount account;
  static GoogleSignInAuthentication authentication;

  ServiceAPI serviceAPI=ServiceAPI();

  Future<String> loginWithGoogle() async {
    await googleSignIn.signOut();
    googleUser = await googleSignIn.signIn();
    if(googleUser != null) {
          account = googleSignIn.currentUser;
          authentication = await account.authentication;
          
          log("auth token : ${authentication.idToken}...**");
          try {
            String res=await serviceAPI.login(authentication.idToken, account.email);
            print("res $res");
            return res;
          }
          catch(e){
            print(e);
            return('Error');
          }
    }
    else {
          return('Error');
    }
  }


  Future<String> signUpWithGoogle() async {
    await googleSignIn.signOut();
    googleUser = await googleSignIn.signIn();
    if(googleUser != null) {
      account = googleSignIn.currentUser;
      authentication = await account.authentication;

      log("auth token : ${authentication.idToken}...**");
      try {
        String res=await serviceAPI.signUp(authentication.idToken, account.email);
        print("res $res");
        return res;
      }
      catch(e){
        print(e);
        return('Error');
      }
    }
    else {
      return('Error');
    }
  }


  Future<void> logoutWithGoogle() async {
    await googleSignIn.signOut();
  }
}