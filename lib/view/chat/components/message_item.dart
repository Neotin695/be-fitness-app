import 'package:be_fitness_app/models/message_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MessageItem extends StatelessWidget {
  final MessageModel message;
  const MessageItem({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final id = FirebaseAuth.instance.currentUser!.uid;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0.5.w, vertical: 2.h),
      width: 80.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: id == message.senderId ? Colors.blue : Colors.cyan),
      child: ListTile(
        title: Text(message.message),
        subtitle: Text(message.time),
        trailing: const Icon(Icons.done),
      ),
    );
  }
}
