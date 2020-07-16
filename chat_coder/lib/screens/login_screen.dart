import 'package:chatcoder/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chatcoder/components/rounded_button.dart';
import 'package:chatcoder/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static const String id='LoginScreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email;
  String password;
  final _auth = FirebaseAuth.instance;
  bool showSpinner=false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //backgroundColor: Colors.white,
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Hero(
                    tag: 'logo',
                    child: Container(
                      height: 200.0,
                      child: Image.asset('images/logo.png'),
                    ),
                  ),
                  SizedBox(
                    height: 48.0,
                  ),
                  TextField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      email=value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter Your Email'
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    textAlign: TextAlign.center,
                    obscureText: true,
                    onChanged: (value) {
                      password=value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter Your Password'
                    ),
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  RoundedButton(
                      color: Colors.blueAccent,
                      buttonTitle: 'Login',
                      onPressed: () async {
                        setState(() {
                          showSpinner=true;
                        });
                        try{
                          final user=await _auth.signInWithEmailAndPassword(email: email, password: password);
                          if(user!=null){
                            Navigator.pushNamed(context, ChatScreen.id);
                          }
                        }
                        catch(e){
                          print(e);
                        }
                        setState(() {
                          showSpinner=false;
                        });
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


