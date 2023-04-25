import 'package:be_fitness_app/view/chat/cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/message_view.dart';

class MessagePage extends StatelessWidget {
  static const String routeName = '/messagePage';
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => ChatCubit(),
        child: const MessageView(),
      ),
    );
  }
}
