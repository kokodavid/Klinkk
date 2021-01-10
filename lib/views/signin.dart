import 'package:flutter/material.dart';
import 'package:klinkk/widgets/widget.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 50,
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  style: simpleTextStyle(),
                  decoration: textFieldInputDecoration("Email")
                ),
                TextField(
                  style: simpleTextStyle(),
                  decoration: textFieldInputDecoration("Password")
                ),
                SizedBox(height: 8,),
                Container(
                  alignment: Alignment.centerRight,
                  child:   Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      "Forgot Password ?",
                      style: simpleTextStyle(),
                    ),
                  ),
                ),
                SizedBox(height: 8,),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xff007EF4),
                        const Color(0xff2A75BC)
                      ]
                    )
                  ),
                  child: Text("Sign In",
                  style: mediumTextStyle(),
                  ),
                ),
                SizedBox(height: 16,),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white
                  ),
                  child: Text("Sign In With Google",
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 17
                    )
                  ),
                ),
                SizedBox(height: 16,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an Account ?",style: mediumTextStyle(),),
                    Text("Register now",style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      decoration: TextDecoration.underline
                    )
                      ,)
                  ],
                ),
                SizedBox(height: 50,),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
