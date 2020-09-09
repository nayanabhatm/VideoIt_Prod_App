import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:videoit/service_api.dart';
import 'package:videoit/constants/Constants.dart';
import 'package:videoit/formatNumber.dart';
import 'package:videoit/models/service_api_response_models.dart';


Column individualCountWidget(String textValue,int countType) {
  return Column(
    children: <Widget>[
      Text(
        formatNumber(countType),
        style: kNumberStyle,
      ),
      Text(
        textValue,
        style: kNumberDescriptionStyle,
      )
    ],
  );
}


CachedNetworkImage getDisplayPic() {
  ServiceAPI serviceAPI=ServiceAPI();
  return CachedNetworkImage(
    imageUrl: kIPAddress + ":8999/session/getDisplayPic/${serviceAPI.username}",
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
      'VI_SESSION': '${serviceAPI.session}',
      'VI_UID': '${serviceAPI.uuid}'
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
                '${serviceAPI.username[0].toString().toUpperCase()}',
                style: kDisplayLetterInImage,
              ),
            ),
          ),
        ),
      );
    },
  );
}
