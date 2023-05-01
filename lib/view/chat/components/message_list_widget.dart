import 'package:be_fitness_app/view/chat/cubit/chat_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../models/message_model.dart';
import 'message_item.dart';

class MessageList extends StatelessWidget {
  final ChatCubit cubit;
  const MessageList({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    final id = FirebaseAuth.instance.currentUser!.uid;
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('chatRooms')
            .doc(cubit.generateRoomId())
            .collection('messages')
            .orderBy('timestamp')
            .snapshots(),
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              reverse: true,
              children: snapshot.data!.docs.reversed.map((doc) {
                final message =
                    MessageModel.fromMap(doc.data() as Map<String, dynamic>);

                return Align(
                  alignment: id != message.senderId
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: MessageItem(message: message),
                );
              }).toList(),
            );
          }
          return const SizedBox(
            child: Text('no Message yet!'),
          );
        });
  }
}
