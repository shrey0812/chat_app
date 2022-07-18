import 'package:chat_app/helper/constants.dart';
import 'package:chat_app/services/database.dart';
import 'package:chat_app/widget/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ConversationScreen extends StatefulWidget {
  final String chatRoomId;

  const ConversationScreen(this.chatRoomId, {Key? key}) : super(key: key);

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  TextEditingController messageTextEditingController = TextEditingController();
  DatabaseMethods databaseMethods = DatabaseMethods();

  Stream<QuerySnapshot> chatMessageString = const Stream.empty();

  Widget chatMessageList() {
    return StreamBuilder(
        stream: chatMessageString,
        builder: ((context, AsyncSnapshot snapshot) {
          return ListView.builder(
              itemCount: snapshot.data().docs.length,
              itemBuilder: (context, index) {
                return MessageTile(snapshot.data().docs[index]["message"]);
              });
        }));
  }

  sendMessage() {
    Map<String, String> messageMap = {};
    if (messageTextEditingController.text.isNotEmpty) {
      messageMap = {
        "message": messageTextEditingController.text,
        "sendBy": Constants.myName,
      };
    }
    databaseMethods.addConversationMessages(widget.chatRoomId, messageMap);
    messageTextEditingController.text = "";
  }

  @override
  void initState() {
    getConvo();
    super.initState();
  }

  getConvo() async {
    await databaseMethods
        .getConversationMessages(widget.chatRoomId)
        .then((value) {
      setState(() {
        chatMessageString = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: appBarMain(context),
      ),
      body: Stack(
        children: [
          chatMessageList(),
          Container(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: const Color(0x54FFFFFF),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageTextEditingController,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Message....',
                        hintStyle: TextStyle(
                          color: Colors.white54,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      sendMessage();
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0x36FFFFFF),
                            Color(0x0FFFFFFF),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Image.asset('assets/images/send.png'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  const MessageTile(this.message, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Text(
      message,
      style: simpleTextStyle(),
    ));
  }
}
