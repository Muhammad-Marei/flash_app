import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flash_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

final _fireStore = FirebaseFirestore.instance;

class ChatScreen extends StatefulWidget {
  static const String id = "ChatScreen";
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

User loggedInUser;

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  final _fireStore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  String messageText;
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user1 = await _auth.currentUser;
      if (user1 != null) {
        loggedInUser = user1;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () async {
                Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            MessageStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      messageTextController.clear();
                      _fireStore.collection('message').add({
                        'text': messageText,
                        'sender': loggedInUser.email,
                      });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _fireStore.collection('message').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
            child: Center(
              child: LiquidCircularProgressIndicator(
                value: 0.2, // Defaults to 0.5.
                valueColor: AlwaysStoppedAnimation(Colors
                    .pink), // Defaults to the current Theme's accentColor.
                backgroundColor: Colors
                    .white, // Defaults to the current Theme's backgroundColor.
                borderColor: Colors.orange,
                borderWidth: 10.0,
                direction: Axis
                    .horizontal, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
                center: Text("Loading..."),
              ),
            ),
          );
        }
        final messages = snapshot.data.docs.reversed;
        List<MessageBubble> messagesBubbles = [];
        for (var message in messages) {
          final messageText = message.data()['text'];
          final messageSender = message.data()['sender'];
          final currentUser = loggedInUser.email;
          final messageBubble = MessageBubble(
            sender: messageSender,
            text: messageText,
            isMe: currentUser == messageSender,
          );
          messagesBubbles.add(messageBubble);
        }
        return Expanded(
            child: ListView(
          reverse: true,
          children: messagesBubbles,
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        ));
      },
    );
  }
}

// ignore: camel_case_types
class MessageBubble extends StatelessWidget {
  final String sender;
  final String text;
  final bool isMe;
  MessageBubble({this.sender, this.text, this.isMe});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(fontSize: 12, color: Colors.black54),
          ),
          Material(
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0))
                : BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0)),
            color: isMe ? Colors.lightBlue : Colors.lightGreenAccent,
            child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "$text ",
                  style: TextStyle(fontSize: 20),
                )),
          ),
        ],
      ),
    );
  }
}
