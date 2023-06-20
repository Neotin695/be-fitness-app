import 'package:be_fitness_app/core/appconstance/logic_constance.dart';
import 'package:be_fitness_app/core/appconstance/media_constance.dart';
import 'package:be_fitness_app/models/chat_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sizer/sizer.dart';

import '../pages/chat_room_page.dart';

class MessageView extends StatefulWidget {
  const MessageView({super.key});

  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  @override
  Widget build(BuildContext context) {
    bool isNew = false;
    return SafeArea(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection(LogicConst.users)
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('conversetions')
            .snapshots(),
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.docs.isEmpty) {
              return Center(
                  child: SvgPicture.asset(
                MediaConst.empty,
                width: 30.w,
                height: 30.h,
              ));
            }
            return ListView(
              children: snapshot.data!.docs.map((doc) {
                final chatRoom =
                    ChatModel.fromMap(doc.data() as Map<String, dynamic>);

                isNew = chatRoom.messageModel.senderId !=
                    FirebaseAuth.instance.currentUser!.uid;
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 2,
                    child: ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, ChatRoomPage.routeName,
                            arguments: FirebaseAuth.instance.currentUser!.uid ==
                                    chatRoom.messageModel.senderId
                                ? chatRoom.messageModel.receiverId
                                : chatRoom.messageModel.senderId);
                      },
                      leading: Icon(
                        Icons.person,
                        size: 25.sp,
                      ),
                      trailing: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Text(
                              chatRoom.messageModel.time,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                          isNew
                              ? Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(365),
                                        color: Colors.green),
                                    child: Text(
                                      'New',
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ),
                                )
                              : const SizedBox()
                        ],
                      ),
                      title: Text(
                        chatRoom.userName,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: 16.sp),
                      ),
                      subtitle: Text(
                        chatRoom.messageModel.message,
                        style: TextStyle(
                            color: isNew ? Colors.green : Colors.grey,
                            fontWeight:
                                isNew ? FontWeight.bold : FontWeight.normal),
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: LoadingAnimationWidget.dotsTriangle(
                    color: Theme.of(context).colorScheme.surfaceTint,
                    size: 35.sp));
          }
          return Center(
              child: SvgPicture.asset(
            MediaConst.empty,
            width: 30.w,
            height: 30.h,
          ));
        },
      ),
    );
  }
}
