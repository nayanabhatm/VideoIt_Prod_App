import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:videoit/user/UserInformation.dart';

import 'package:videoit/constants/SizeConfig.dart';
import 'package:videoit/constants/Constants.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GoogleSignIn googleSignIn;
  UserInformation userInformation = UserInformation();

  @override
  void initState() {
    super.initState();
    googleSignIn = GoogleSignIn(clientId: kclientId);
    googleSignIn.signOut();
    checkSignedInStatus();
  }


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return new Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                padding: EdgeInsets.fromLTRB(0,  SizeConfig.blockSizeVertical*15 , 0.0, 0.0),
                child: Center(
                  child: Text(
                    "VideoIt",
                    style: kHeaderStyle,
                  ),
                )
            ),
            Container(
                padding: EdgeInsets.fromLTRB(0, SizeConfig.blockSizeVertical*25, 0.0, 0.0),
                child: Center(
                  child: Text(
                    "Lights Camera Action",
                    style: kSubHeaderStyle,
                  ),
                )
            ),
            SizedBox(height: SizeConfig.safeBlockHorizontal*70),
            CircularProgressIndicator (
              backgroundColor: Colors.white,
            )
          ],
        ),
    );
  }

  void checkSignedInStatus() async {
    await Future.delayed(Duration(seconds: 3));
    bool isUserSignedIn = await googleSignIn.isSignedIn();

    if(isUserSignedIn) {
        GoogleSignInAccount user = await googleSignIn.signIn();
        GoogleSignInAccount account = googleSignIn.currentUser;

        if(account != null) {
          GoogleSignInAuthentication authentication = await account.authentication;
          userInformation.setEmailId(account.email);
          userInformation.setUsername(account.displayName);
          userInformation.setToken(authentication.idToken);
          Navigator.pushReplacementNamed(context, "/userprofile");
        }
        else {
           Navigator.pushReplacementNamed(context, "/login");
        }
    }
    else {
      Navigator.pushReplacementNamed(context, "/login");
    }

  }

}

