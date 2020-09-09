import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:videoit/service_api.dart';
import 'package:videoit/constants/Constants.dart';
import 'package:videoit/user/User.dart';
import 'package:videoit/pages/profile/ProfileDPAndCountWidget.dart';

class MyUserProfile extends StatefulWidget{
  @override
  _MyUserProfileState createState() => _MyUserProfileState();
}

class _MyUserProfileState extends State<MyUserProfile> {
  Future futureUserProfileDetails;
  Future futureVideoList;
  CachedNetworkImage userDisplayPic;
  ServiceAPI serviceAPI=ServiceAPI();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    try {
      futureUserProfileDetails = serviceAPI.getUser();
      userDisplayPic=getDisplayPic();
      futureVideoList=serviceAPI.getUserVideos();
      //futureVideoList.then((value) => print("uservideodetails: ${value[0].videoId} ${value[1].videoId}-----$value"));
    }
    catch (e) {
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
            body: Container(
        color: Colors.blueGrey.shade900,
        padding: EdgeInsets.only(top: 30.0),
        child: FutureBuilder(
          future: Future.wait([futureUserProfileDetails,futureVideoList]),
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.hasData) {
              print("aaaaaaa ${snapshot.data[1]} ${snapshot.data[0]}");
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 10.0),
                      width: 180,
                      height: 180,
                      child: userDisplayPic,
                    ),
                  ),
                  SizedBox(height: 8.0,),
                  Center(
                    child: Text(
                        '${snapshot.data[0].userName}',
                        //'${snapshot.data.userName[0].toString().toUpperCase()}${snapshot.data.userName.toString().substring(1)}',
                        style: kNameStyle
                    ),
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        color: Colors.pink.shade400,
                        child: Text(
                            'Edit Profile'),
                        onPressed: () {

                        },
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 18.0, right: 18.0, bottom: 12.0, top: 6.0),
                    child: Center(
                      child: Text(
                        //'${snapshot.data.userDescription ?? 'Description'}',
                        "Description is null for now. No field",
                        textAlign: TextAlign.center,
                        style: kDescriptionStyle,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: individualCountWidget("Posts",snapshot.data[0].videoCount),
                      ),
                      Expanded(
                        child: individualCountWidget("Followers", snapshot.data[0].followersCount),
                      ),
                      Expanded(
                        child: individualCountWidget("Following",snapshot.data[0].followingCount),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.0,),
                  Expanded(
                    child: GridView.builder(
                        physics: BouncingScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        ),
                        itemCount: (snapshot.data[1] !=null)? snapshot.data[1].length:0,
                        itemBuilder: (context, index) {
                        return Container(
                        child: (snapshot.data[1] !=null)? Image.network(
                          "$kIPAddress:9000/content/management/video/getThumbnail/${snapshot.data[1][index].videoId.toString()}",
                          headers: {'Content-Type':'application/json','VI_SESSION':'${serviceAPI.session}','VI_UID':'${serviceAPI.uuid}'},
                          fit: BoxFit.cover,
                        ): Container(),
                        //color: Colors.blueAccent,
                        );
                      }
                    ),
                  )
                ],
              );
            }
            else if (snapshot.hasError) {
              print(snapshot.error);
              return Text("${snapshot.error}");
            }
            return Center(child: CircularProgressIndicator(backgroundColor: Colors.white, strokeWidth: 4.0,));
          },
        ),
      ),
    );
  }
}


