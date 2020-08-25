import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:videoit/APICalls.dart';
import 'package:videoit/constants/Constants.dart';
import 'package:videoit/user/User.dart';

class UserProfile extends StatefulWidget{
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  Future futureUserProfileDetails;
  CachedNetworkImage userDisplayPic;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    try {
      futureUserProfileDetails = APICalls.getUser();
      getDisplayPic();
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
          future: futureUserProfileDetails,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
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
                        '${snapshot.data.username}',
                        //'${snapshot.data.userName[0].toString().toUpperCase()}${snapshot.data.userName.toString().substring(1)}',
                        style: kNameStyle
                    ),
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        color: Colors.pink.shade400,
                        child: Text('Follow'),
                        onPressed: () {
                            APICalls.incrementFollow();
                        },
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 18.0, right: 18.0, bottom: 12.0, top: 6.0),
                    child: Center(
                      child: Text(
                        '${snapshot.data.userDescription ?? 'Description'}',
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
                              formatNumber(snapshot.data.videoCount),
                              style: kNumberStyle,
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
                              formatNumber(snapshot.data.followersCount),
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
                              formatNumber(snapshot.data.followingCount),
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
                  SizedBox(height: 2.0,),
                  Expanded(
                    child: GridView.builder(
                        physics: BouncingScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                        ),
                        itemCount: 12,
                        itemBuilder: (context, index) {
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
            else if (snapshot.hasError) {
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

  String formatNumber(int value) {
    return NumberFormat.compactCurrency(
        decimalDigits: 0,
        symbol: ''
    ).format(value);
  }

  void getDisplayPic() {
    userDisplayPic = CachedNetworkImage(
      imageUrl: kIPAddress + "/session/getDisplayPic/${User.username}",
      imageBuilder: (context, imageProvider) {
        return Container(
          width: 180,
          height: 180,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                  width: 2, color: Colors.white, style: BorderStyle.solid),
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              )
          ),
        );
      },
      httpHeaders: {
        'Content-Type': 'application/json',
        'VI_SESSION': '${User.session}',
        'VI_UID': '${User.uuid}'
      },
      placeholder: (context, url) {
        return CircularProgressIndicator();
      },
      errorWidget: (context, err, o) {
        print(err);
        return Container(
          width: 180,
          height: 180,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                  width: 2, color: Colors.white, style: BorderStyle.solid),
              image: DecorationImage(
                image: AssetImage('assets/blackbkg.jpeg'),
                fit: BoxFit.cover,
              )
          ),
          child: Container(
            child: Center(
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  '${User.username[0].toString().toUpperCase()}',
                  style: kDisplayLetterInImage,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

}