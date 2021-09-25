import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_app/component/messageBubble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//model
class MessageStream extends StatelessWidget {

  final _fireStore = FirebaseFirestore.instance;
  User loggedInUser;
  MessageStream(this.loggedInUser);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _fireStore.collection('message').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),

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