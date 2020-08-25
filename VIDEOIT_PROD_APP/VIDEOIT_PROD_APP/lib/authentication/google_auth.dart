import 'dart:developer';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:videoit/APICalls.dart';
import 'package:videoit/constants/Constants.dart';

class Auth{
  static GoogleSignIn googleSignIn = GoogleSignIn(clientId: kclientId);
  static GoogleSignInAccount googleUser;
  static GoogleSignInAccount account;
  static GoogleSignInAuthentication authentication;

  static Future<String> loginWithGoogle() async {
    await googleSignIn.signOut();
    googleUser = await googleSignIn.signIn();
    if(googleUser != null) {
          account = googleSignIn.currentUser;
          authentication = await account.authentication;
          
          log("auth token : ${authentication.idToken}...**");
          try {
            await APICalls.loginToVideoIt(authentication.idToken, account.email);
            return ('success');
          }
          catch(e){
            print(e);
            return('fail');
          }
    }
    else {
          return('fail');
    }
  }


  static Future<String> signUpWithGoogle() async {
    await googleSignIn.signOut();
    googleUser = await googleSignIn.signIn();
    if(googleUser != null) {
      account = googleSignIn.currentUser;
      authentication = await account.authentication;

      log("auth token : ${authentication.idToken}...**");
      try {
        await APICalls.signUpWithVideoIt(authentication.idToken, account.email);
        return ('success');
      }
      catch(e){
        print(e);
        return('fail');
      }
    }
    else {
      return('fail');
    }
  }


  static Future<void> logoutWithGoogle() async {
    await googleSignIn.signOut();
  }
}