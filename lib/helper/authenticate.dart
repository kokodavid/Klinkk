import 'package:flutter/material.dart';
import 'package:klinkk/views/signin.dart';
import 'package:klinkk/views/signup.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignInScreen = true;

  void toggleView() {
    setState(() {
      showSignInScreen = !showSignInScreen;
    });
  }


  @override
  Widget build(BuildContext context) {
    if (showSignInScreen) {
      return SignIn(toggleView);
    } else {
      return SignUp(toggleView);
    }
  }
}
