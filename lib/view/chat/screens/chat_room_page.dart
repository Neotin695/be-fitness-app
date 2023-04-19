import 'package:be_fitness_app/view/chat/components/chat_room_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/chat_cubit.dart';

class ChatRoomPage extends StatelessWidget {
  static const String routeName = '/chatRoom';
  const ChatRoomPage({super.key});

  @override
  Widget build(BuildContext context) {
    final receiverId = ModalRoute.of(context)!.settings.arguments as String;
    return BlocProvider(
      create: (context) => ChatCubit(),
      child: ChatRoomView(receiverId: receiverId),
    );
  }
}
