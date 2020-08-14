import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:videoit/constants/Constants.dart';
import 'package:videoit/user/User.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:videoit/user/UserProfile.dart';

class UserProfile extends StatefulWidget{
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final GoogleSignIn googleSignIn = GoogleSignIn(clientId:kclientId);
  Future<UserProfileDetails> futureUserProfileDetails;


  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    futureUserProfileDetails=getUser();
  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top:30.0),
        child: FutureBuilder(
          future: futureUserProfileDetails,
          builder: (context,snapshot){
            if(snapshot.hasData){
               return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 10.0),
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                              "http://192.168.0.102:8999/session/getDisplayPic/${User.username}",
                              headers: {'Content-Type':'application/json','VI_SESSION':'${User.session}','VI_UID':'${User.uuid}'}
                          ),
                        )
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0,),
                  Center(
                    child: Text(
                         '${snapshot.data.userName}',
                        //'${snapshot.data.userName[0].toString().toUpperCase()}${snapshot.data.userName.toString().substring(1)}',
                        style: kNameStyle
                    ),
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        child: Text('Follow'),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        onPressed: (){


                        },
                      ),
                      RaisedButton(
                        color: Colors.pink.shade400,
                        child: Text('Edit Profile'),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        onPressed: (){

                        },
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Center(
                      child: Text(
                        '${snapshot.data.userDescription}',
                        textAlign: TextAlign.center,
                        style: kDescriptionStyle,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Text(
                              '${snapshot.data.videoCount}',
                              style:kNumberStyle,
                            ),
                            Text(
                              "Posts",
                              style: kNumberDescriptionStyle,
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Text(
                              '${snapshot.data.followersCount}',
                              style: kNumberStyle,
                            ),
                            Text(
                              "Followers",
                              style: kNumberDescriptionStyle,
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Text(
                              '${snapshot.data.followingCount}',
                              style: kNumberStyle,
                            ),
                            Text(
                              "Following",
                              style: kNumberDescriptionStyle,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0,),
                  Expanded(
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                        ),
                        itemCount: 12,
                        itemBuilder: (context,index){
                          return Container(
                            child: Image.asset(
                              'assets/avatar2.jpg',
                              fit: BoxFit.cover,
                            ),
                          );
                        }
                    ),
                  )
                ],
              );
            }
            else if(snapshot.hasError){
              print(snapshot.error);
              return Text("${snapshot.error}");
            }
            return Center(child: CircularProgressIndicator(
              backgroundColor: Colors.white,
            ));
          },
        ),
      ),
    );
  }

  Future<UserProfileDetails> getUser() async{
    final String url="http://192.168.0.102:8999/session/getUser/${User.username}";
    Map<String,String> requestHeaders= {'Content-Type':'application/json','VI_SESSION':'${User.session}','VI_UID':'${User.uuid}'};
    final getUserResponse= await http.get(url,headers: requestHeaders);
    print("....${getUserResponse.body}....");
    if(getUserResponse.statusCode == 200)
      return UserProfileDetails.fromJson(convert.jsonDecode(getUserResponse.body));
    else
      throw Exception("Failed to load User details");
  }


  Future<void> getDisplayPic() async{
    final String url="http://192.168.0.102:8999/session/getDisplayPic/${User.username}";
    Map<String,String> requestHeaders= {'Content-Type':'application/json','VI_SESSION':'${User.session}','VI_UID':'${User.uuid}'};
    final getUserResponse= await http.get(url,headers: requestHeaders);
    print("....${getUserResponse.body}....");
//    if(getUserResponse.statusCode == 200)
//      //return UserProfileDetails.fromJson(convert.jsonDecode(getUserResponse.body));
//    else
//      throw Exception("Failed to load User details");
  }

}

