import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:klinkk/helper/authenticate.dart';
import 'package:klinkk/helper/helperfunctions.dart';
import 'package:klinkk/views/chatRoomScreen.dart';
import 'package:klinkk/views/search.dart';
import 'package:klinkk/views/signin.dart';
import 'package:klinkk/views/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool userLoggedIn = false;
  
  @override
  void initState() {
    getLoggedInState();
    super.initState();
  }
  
  getLoggedInState() async{
    await HelperFunctions.getUserLoggedInSharedPreference().then((value){
        setState(() {
          userLoggedIn = value;
        });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Klinkk',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff145C9E),
        scaffoldBackgroundColor: Color(0xff1F1F1F),
        primarySwatch: Colors.blue,
      ),
      home: userLoggedIn ? ChatRoom() : Authenticate() ,
    );
  }
}


//TODO
class NullWidget extends StatefulWidget {
  @override
  _NullWidgetState createState() => _NullWidgetState();
}

class _NullWidgetState extends State<NullWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}



