import 'package:be_fitness_app/view/chat/cubit/chat_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'message_item.dart';

class MessageList extends StatelessWidget {
  final ChatCubit cubit;
  const MessageList({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    final id = FirebaseAuth.instance.currentUser!.uid;
    return ListView.builder(
      reverse: true,
      itemCount: cubit.fetchMessages().length,
      itemBuilder: (context, index) {
        final message = cubit.fetchMessages()[index];
        return Align(
          alignment: id == message.senderId
              ? Alignment.centerLeft
              : Alignment.centerRight,
          child: MessageItem(message: message),
        );
      },
    );
  }
}
