import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:videoit/constants/Constants.dart';
import 'package:videoit/user/UserInformation.dart';

class UserProfile extends StatefulWidget {
  UserProfile({Key key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile>
{

  GoogleSignIn googleSignIn = GoogleSignIn(clientId: kclientId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            child: Text(
              UserInformation.emailId,
              style: TextStyle(
                color: Colors.white
              ),
            ),
          ),
          Container(
            child: Text(
              UserInformation.username,
              style: TextStyle(
                  color: Colors.white
              ),
            ),
          ),
          Container(
            child: RaisedButton(onPressed: () {
              googleSignIn.signOut();
              Navigator.pushReplacementNamed(context, "/");
            },
            child: Text(
              "log out"
            ),)
          ),
        ],
      ),
      backgroundColor: Colors.black,
    );
  }
  
}