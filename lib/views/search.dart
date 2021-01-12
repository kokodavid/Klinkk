import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:klinkk/helper/constants.dart';
import 'package:klinkk/services/database.dart';
import 'package:klinkk/views/conversation.dart';
import 'package:klinkk/widgets/widget.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController searchTextEditingController = new TextEditingController();
  QuerySnapshot searchSnapshot;


  initiateSearch(){
    databaseMethods.getUserByUsername(searchTextEditingController.text)
        .then((val){
          setState(() {
            searchSnapshot = val;
          });
    });
  }


  Widget searchList(){
    return searchSnapshot != null ? ListView.builder(
        itemCount: searchSnapshot.docs.length,
        shrinkWrap: true,
        itemBuilder: (context, index){
          return SearchTile(
            userName: searchSnapshot.docs[index].data()["name"],
            email: searchSnapshot.docs[index].data()["email"],
          );
        }) : Container();


  }



  @override
  void initState() {
    initiateSearch();
    super.initState();
  }

  ///create Chat Room
  createChatRoomAndStartConversation({String username}){
    // if(username != Constants.myName){
      String chatRoomId = getChatRoomID(username, Constants.myName);

      List<String> users = [username, Constants.myName];
      Map<String,dynamic> chatRoomMap = {
        "users": users,
        "chatRoomId": chatRoomId
      };
      DatabaseMethods().createChatRoom(chatRoomId, chatRoomMap);
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => ConversationScreen()
      ));
    // }else{
    //   print ("You Can't talk to your self mad man");
    // }

  }

Widget SearchTile({String userName, String email}){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32,vertical: 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(userName, style: mediumTextStyle(),),
              Text(email, style: mediumTextStyle(),)
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              createChatRoomAndStartConversation(
                username: userName
              );
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(30)
              ),
              padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
              child: Text("Message",style: mediumTextStyle(),),
            ),
          )
        ],
      ),
    );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        child: Column(
          children: [
            Container(
              color: Color(0x54FFFFFF),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                        controller: searchTextEditingController,
                        style: TextStyle(
                            color: Colors.white
                        ),
                        decoration: InputDecoration(
                          hintText: "Search Username",
                          hintStyle: TextStyle(
                            color: Colors.white54
                          ),
                          border: InputBorder.none
                        ),
                      )
                  ),
                  GestureDetector(
                    onTap: (){
                      initiateSearch();
                    },
                    child: Container(
                      height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color(0x36FFFFFF),
                              const Color(0x0FFFFFFF)
                            ]
                          ),
                          borderRadius: BorderRadius.circular(40)
                        ),
                        padding: EdgeInsets.all(12),
                        child: Image.asset("assets/images/search_white.png")),
                  )
                ],
              ),
            ),
            searchList(),
          ],
        ),
      ),
    );
  }
}




getChatRoomID(String a, String b){
  if(a.substring(0,1).codeUnitAt(0) > b.substring(0,1).codeUnitAt(0)) {
    return"$b\_$a";
  } else {
    return "$a\_$b";
  }
}

