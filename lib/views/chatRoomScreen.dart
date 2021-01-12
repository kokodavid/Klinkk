import 'package:flutter/material.dart';
import 'package:klinkk/helper/authenticate.dart';
import 'package:klinkk/helper/constants.dart';
import 'package:klinkk/helper/helperfunctions.dart';
import 'package:klinkk/services/auth.dart';
import 'package:klinkk/views/search.dart';
import 'package:klinkk/views/signin.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {

  AuthMethods authMethods = new AuthMethods();

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo()async{

    Constants.myName = await HelperFunctions.getUserNameInSharedPreference();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Klinkk"),
        actions: [
          GestureDetector(
            onTap: (){
              authMethods.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) => Authenticate()
              ));
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.exit_to_app)),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => Search()
          ));
        },
      ),
    );
  }
}
