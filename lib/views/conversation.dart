import 'package:flutter/material.dart';
import 'package:klinkk/helper/constants.dart';
import 'package:klinkk/services/database.dart';
import 'package:klinkk/widgets/widget.dart';

class ConversationScreen extends StatefulWidget {
  final String chatRoomId;
  ConversationScreen(this.chatRoomId);
  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {

  TextEditingController messageTextEditingController = TextEditingController();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  Stream chatMessagesStream;

  Widget ChatMessageList(){
    return StreamBuilder(
      stream: chatMessagesStream,
      builder: (context, snapshot){
        if(snapshot.data == null) return CircularProgressIndicator();
        return ListView.builder(
          itemCount: snapshot.data.documents.length,
          itemBuilder: (context, index){
            return MessageTile(snapshot.data.documents[index].data()["message"],
                snapshot.data.documents[index].data()["sendBy"] == Constants.myName);
          },
        );
      },
    );
  }

  sendMessage(){
    if(messageTextEditingController.text.isNotEmpty){
      Map<String,dynamic> messageMap = {
        "message": messageTextEditingController.text,
        "sendBy": Constants.myName,
        "time": DateTime.now().millisecondsSinceEpoch
      };
      databaseMethods.addConversationMessages(widget.chatRoomId, messageMap);
      messageTextEditingController.text = "";
    }

  }

  @override
  void initState() {
    databaseMethods.getConversationMessages(widget.chatRoomId).then((value){
      setState(() {
        chatMessagesStream = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        child: Stack(
          children: [
            ChatMessageList(),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Color(0x54FFFFFF),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                          controller: messageTextEditingController,
                          style: TextStyle(
                              color: Colors.white
                          ),
                          decoration: InputDecoration(
                              hintText: "Message...",
                              hintStyle: TextStyle(
                                  color: Colors.white54
                              ),
                              border: InputBorder.none
                          ),
                        )
                    ),
                    GestureDetector(
                      onTap: (){
                        sendMessage();
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
                          child: Image.asset("assets/images/send.png")),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class MessageTile extends StatelessWidget {
  final bool myText;
  final String message;
  MessageTile(this.message,this.myText);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: myText ? 80: 24, right: myText ? 24:80),
      margin: EdgeInsets.symmetric(vertical: 8),
      width: MediaQuery.of(context).size.width,
      alignment: myText ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: myText ? [
                const Color(0xff007EF4),
                const Color(0xff2A75BC)
            ]  :[
              const Color(0x1AFFFFFF),
              const Color(0x1AFFFFFF)
            ]
          ),
          borderRadius: myText ? BorderRadius.only(
            topLeft: Radius.circular(23),
            topRight: Radius.circular(23),
            bottomLeft: Radius.circular(23)
          ) : BorderRadius.only(
              topLeft: Radius.circular(23),
              topRight: Radius.circular(23),
              bottomRight: Radius.circular(23)
          )
        ),
        child: Text(message,style: TextStyle(
            color: Colors.white,
            fontSize: 17
        )),
      ),
    );
  }
}

