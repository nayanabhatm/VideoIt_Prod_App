import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:videoit/authentication/google_auth.dart';
import 'package:videoit/constants/Constants.dart';
import 'package:videoit/constants/SizeConfig.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(0,  SizeConfig.blockSizeVertical*15 , 0.0, 0.0),
                child: Text(
                  "VideoIt",
                  style: kHeaderStyle,
                   )
                 ),
              Container(
                child: Text(
                  "Lights Camera Action",
                  style: kSubHeaderStyle,
                )
              ),
              SizedBox(height: SizeConfig.blockSizeHorizontal*60),
              Container(
                height: SizeConfig.safeBlockHorizontal*15,
                color: Colors.transparent,
                padding: EdgeInsets.fromLTRB(SizeConfig.safeBlockHorizontal*8, 0.0, SizeConfig.safeBlockHorizontal*8, 0.0),
                child: Container(
                    decoration: kBoxDecoration,
                    child: GestureDetector(
                      onTap: () async {
                        String loginReturnVal=await Auth.loginWithGoogle();
                        print("loginReturnval...$loginReturnVal");
                        if(loginReturnVal=='success') {
                          Navigator.pushReplacementNamed(context, "/videoplay");
                        }
                        else
                            Navigator.pushReplacementNamed(context, "/");
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            "assets/google.png",
                            height: SizeConfig.safeBlockHorizontal*10,
                            width: SizeConfig.safeBlockHorizontal*10,
                          ),
                          Text(
                            "Login with Google",
                            style:ksignInStyle,
                          )
                        ],
                      ),
                    )
                ),
              ),
              SizedBox(height: SizeConfig.safeBlockHorizontal*4),
              Container(
                height: SizeConfig.safeBlockHorizontal*15,
                color: Colors.transparent,
                padding: EdgeInsets.fromLTRB(SizeConfig.safeBlockHorizontal*8, 0.0, SizeConfig.safeBlockHorizontal*8, 0.0),
                child: Container(
                    decoration: kBoxDecoration,
                    child: GestureDetector(
                      onTap: () async{
//                      String signUpReturnVal=await auth.signUpWithGoogle();
//                      if(signUpReturnVal=='success')
//                        Navigator.pushReplacementNamed(context, "/videoplay");
//                      else
//                        Navigator.pushReplacementNamed(context, "/");

                      },
                      child : Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Image.asset(
                              "assets/google.png",
                              height: SizeConfig.safeBlockHorizontal*10,
                              width: SizeConfig.safeBlockHorizontal*10,
                            ),
                            Text(
                              "Sign up with Google",
                              style: ksignInStyle,
                            )
                          ],
                        ),
                      ),
                    )
                ),
              ),
              SizedBox(height: SizeConfig.safeBlockHorizontal*4),
              Container(
                height: SizeConfig.safeBlockHorizontal*15,
                color: Colors.transparent,
                padding: EdgeInsets.fromLTRB(SizeConfig.safeBlockHorizontal*8, 0.0, SizeConfig.safeBlockHorizontal*8, 0.0),
                child: Container(
                  decoration: kBoxDecoration,
                  child: GestureDetector(
                      onTap: () {

                      },
                      child: Center(
                        child: Text(
                          "Continue as Anonymous",
                          style: kAnonymousStyle,
                        ),
                      )
                  ),
                ),
              )
            ],
          ),
        ),
        backgroundColor: Colors.black
    );
  }


}
