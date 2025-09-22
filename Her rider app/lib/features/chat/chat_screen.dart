import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:her_user_app/features/chat/input_bar.dart';
import 'package:her_user_app/features/chat/message_bubble.dart';

class ChatScreen extends StatefulWidget {
  final String tripId;

  const ChatScreen({Key? key, required this.tripId}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  void _sendMessage(String message) {
    FirebaseFirestore.instance
        .collection('chat_messages')
        .doc(widget.tripId)
        .collection('messages')
        .add({
      'text': message,
      'timestamp': Timestamp.now(),
      'userId': FirebaseAuth.instance.currentUser!.uid,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('chat_messages')
                  .doc(widget.tripId)
                  .collection('messages')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  reverse: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final message = snapshot.data!.docs[index];
                    return MessageBubble(
                      text: message['text'],
                      isMe: message['userId'] ==
                          FirebaseAuth.instance.currentUser!.uid,
                    );
                  },
                );
              },
            ),
          ),
          InputBar(onSendMessage: _sendMessage),
        ],
      ),
    );
  }
}
