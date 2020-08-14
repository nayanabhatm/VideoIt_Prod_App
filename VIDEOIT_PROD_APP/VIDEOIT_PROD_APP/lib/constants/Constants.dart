import 'package:flutter/material.dart';

import 'SizeConfig.dart';

final kclientId="328151025381-k85qilpb2jutoavol4tfvioia10bq5ui.apps.googleusercontent.com";

final kNumberStyle=TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.bold
);

final kNameStyle=TextStyle(
    fontSize: 28.0,
    fontWeight: FontWeight.bold,
);

final kDescriptionStyle=TextStyle(
  fontSize: 18.0,
);

final kNumberDescriptionStyle=TextStyle(
  fontSize: 16.0,
);

final kSubHeaderStyle=TextStyle(
fontSize: SizeConfig.safeBlockHorizontal*4,
fontWeight: FontWeight.bold,
color: Colors.white
);

final kHeaderStyle=TextStyle(
    fontSize: SizeConfig.safeBlockHorizontal*15 ,
    fontWeight: FontWeight.bold,
    color: Colors.white
);

final kAnonymousStyle=TextStyle(
fontSize: SizeConfig.safeBlockHorizontal*5,
fontWeight: FontWeight.normal,
color: Colors.blueAccent,
);

final ksignInStyle=TextStyle(
  fontSize: SizeConfig.safeBlockHorizontal*5,
  fontWeight: FontWeight.normal,
  color: Colors.white,
);


final kBoxDecoration=BoxDecoration(
    border: Border.all(
        color: Colors.white,
        style: BorderStyle.solid,
        width: 1.0
    ),
    borderRadius: BorderRadius.all(Radius.circular(30)),
    color: Colors.transparent
);