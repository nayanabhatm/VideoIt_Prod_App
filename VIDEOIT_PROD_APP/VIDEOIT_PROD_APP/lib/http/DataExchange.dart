import 'dart:convert';
import 'dart:html';

import 'package:videoit/user/User.dart';

import 'Links.dart';
import 'package:http/http.dart' as http;

class DataExchange {

  Links _links;

  void init(Links aLinks) {
    _links = aLinks;
  }

  Future<User> doLogIn(String aUserName, String aTokenId) async {
    try{
      String basicAuth = 'Basic '+base64Encode(utf8.encode('$aUserName:$aTokenId'));
      var requestBody = "";
      var response = await http.post(_links.getLoginUrl, body : requestBody, headers: <String, String>{'authorization':basicAuth});

      if(response.statusCode == HttpStatus.ok) {
        print(response.body);
      }
      else {

      }

    }
    finally{

    }
    return User();
  }

  Future<User> doSignUp(String aUserName, String aTokenId) async {
    try{
      var requestBody = "{ 'authProvider' : '$aUserName', 'authToken' : '$aTokenId' }";
      var response = await http.post(_links.getSignUpUrl, body : requestBody, headers: _links.getSignUpUrlHeaders);

      if(response.statusCode == HttpStatus.ok) {
        print(response.body);
      }
      else {

      }

    }
    finally{

    }
    return User();
  }

  Future<User> doAnonymousSignUp() async {
      try{
        var response = await http.post(_links.getSignUpAnonymousUrl, headers: _links.getSignUpUrlHeaders);

        if(response.statusCode == HttpStatus.ok) {
          print(response.body);
        }
        else {

        }

      }
      finally{

      }
      return User();
    }



}