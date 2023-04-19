import 'package:be_fitness_app/view/chat/cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'input_message_widget.dart';
import 'message_list_widget.dart';

class ChatRoomView extends StatelessWidget {
  final String receiverId;
  const ChatRoomView({super.key, required this.receiverId});

  @override
  Widget build(BuildContext context) {
    ChatCubit cubit = ChatCubit.get(context);
    cubit.receiverId = receiverId;
    return BlocListener<ChatCubit, ChatState>(
      listener: (context, state) {},
      child: Scaffold(
        appBar: AppBar(),
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
      ),
    );
  }
}
