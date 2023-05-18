import 'package:be_fitness_app/core/appconstance/logic_constance.dart';
import 'package:be_fitness_app/core/service/notification/messaging.dart';
import 'package:be_fitness_app/view/chat/cubit/chat_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../core/appconstance/media_constance.dart';
import 'input_message_widget.dart';
import 'message_list_widget.dart';

class ChatRoomView extends StatefulWidget {
  final String receiverId;
  const ChatRoomView({super.key, required this.receiverId});

  @override
  State<ChatRoomView> createState() => _ChatRoomViewState();
}

class _ChatRoomViewState extends State<ChatRoomView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Messaging().onMessaging();
  }

  @override
  Widget build(BuildContext context) {
    ChatCubit cubit = ChatCubit.get(context);
    cubit.receiverId = widget.receiverId;
    return BlocListener<ChatCubit, ChatState>(
      listener: (context, state) {},
      child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection(LogicConst.users)
              .doc(widget.receiverId)
              .snapshots(),
          builder: (context, snapshot) {
            final String profilePhoto = !snapshot.hasData
                ? ''
                : (snapshot.data!.data()
                    as Map<String, dynamic>)['profilePhoto'];
            final String userName = !snapshot.hasData
                ? ''
                : (snapshot.data!.data() as Map<String, dynamic>)['userName'];
            return Scaffold(
              appBar: AppBar(
                title: Row(
                  children: [
                    profilePhoto.isNotEmpty
                        ? CircleAvatar(
                            radius: 18.sp,
                            foregroundImage: NetworkImage(profilePhoto),
                          )
                        : CircleAvatar(
                            radius: 35.sp,
                            backgroundImage:
                                const AssetImage(MediaConst.border),
                            foregroundImage:
                                const AssetImage(MediaConst.person),
                          ),
                    SizedBox(width: 3.w),
                    Text(userName),
                  ],
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: MessageList(
                      cubit: cubit,
                    ),
                  ),
                  InputMessage(
                    cubit: cubit,
                  ),
                ],
              ),
            );
          }),
    );
  }
}
