import 'package:be_fitness_app/models/message_model.dart';
import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MessageItem extends StatelessWidget {
  final MessageModel message;
  const MessageItem({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final id = FirebaseAuth.instance.currentUser!.uid;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BubbleSpecialOne(
          text: message.message,
          seen: message.isSeen,
          sent: true,
          
          isSender: isSender(id),
          color: isSender(id) ? Colors.blue : Colors.blueAccent,
          textStyle: const TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Align(
              alignment:
                  isSender(id) ? Alignment.centerRight : Alignment.centerLeft,
              child: Text(message.time)),
        ),
        SizedBox(height: 1.h)
      ],
    );
  }

  bool isSender(String id) => id == message.senderId;
}
