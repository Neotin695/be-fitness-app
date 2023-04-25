import 'package:be_fitness_app/core/appconstance/logic_constance.dart';
import 'package:be_fitness_app/core/appconstance/media_constance.dart';
import 'package:be_fitness_app/models/chat_model.dart';
import 'package:be_fitness_app/view/chat/cubit/chat_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../screens/chat_room_page.dart';

class MessageView extends StatelessWidget {
  const MessageView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = ChatCubit.get(context);
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection(LogicConst.users)
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('conversetions')
          .snapshots(),
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          return ListView(
            children: snapshot.data!.docs.map((doc) {
              final chatRoom =
                  ChatModel.fromMap(doc.data() as Map<String, dynamic>);
              return ListTile(
                onTap: () {
                  Navigator.pushNamed(context, ChatRoomPage.routeName,
                      arguments: FirebaseAuth.instance.currentUser!.uid ==
                              chatRoom.messageModel.senderId
                          ? chatRoom.messageModel.receiverId
                          : chatRoom.messageModel.senderId);
                },
                leading: const Icon(Icons.person),
                title: Text(chatRoom.userName),
                subtitle: Text(chatRoom.messageModel.message),
              );
            }).toList(),
          );
        }
        return Center(child: SvgPicture.asset(MediaConstance.empty));
      },
    );
  }
}