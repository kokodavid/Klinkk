import 'package:flutter/material.dart';
import 'package:klinkk/helper/authenticate.dart';
import 'package:klinkk/helper/constants.dart';
import 'package:klinkk/helper/helperfunctions.dart';
import 'package:klinkk/services/auth.dart';
import 'package:klinkk/services/database.dart';
import 'package:klinkk/views/conversation.dart';
import 'package:klinkk/views/search.dart';
import 'package:klinkk/views/signin.dart';
import 'package:klinkk/widgets/widget.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {

  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  Stream chatRoomsStream;

  Widget chatRoomList(){
    return StreamBuilder(
      stream: chatRoomsStream,
      builder: (context, snapshot){
        if(snapshot.data == null) return CircularProgressIndicator();
        return  ListView.builder(
          itemCount: snapshot.data.documents.length,
          itemBuilder: (context, index){
            return ChatRoomTiles(snapshot.data.documents[index].data()["chatRoomId"]
                .toString().replaceAll("_", "").replaceAll(Constants.myName, ""),
                snapshot.data.documents[index].data()["chatRoomId"]
            );

          });
      },
    );
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo()async{
    Constants.myName = await HelperFunctions.getUserNameInSharedPreference();
    databaseMethods.getChatRooms(Constants.myName).then((value){
      setState(() {
        chatRoomsStream = value;
      });
    });
    setState(() {

    });
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
      body: chatRoomList(),
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

class ChatRoomTiles extends StatelessWidget {
  final String userName;
  final String chatRoomId;
  ChatRoomTiles(this.userName, this.chatRoomId);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => ConversationScreen(chatRoomId)
        ));
      },
      child: Container(
        color: Colors.black26,
        padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(40)
              ),
              child: Text("${userName.substring(0,1).toUpperCase()}",style: mediumTextStyle()),
            ),
            SizedBox(width: 8),
            Text(userName, style: mediumTextStyle(),)
          ],
        ),
      ),
    );
  }
}
