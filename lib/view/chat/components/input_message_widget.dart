import 'package:be_fitness_app/view/chat/cubit/chat_cubit.dart';
import 'package:flutter/material.dart';

class InputMessage extends StatelessWidget {
  final ChatCubit cubit;
  const InputMessage({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: cubit.message,
      decoration: InputDecoration(
          hintText: 'Type a message...',
          border: InputBorder.none,
          suffix: IconButton(
            onPressed: () async => await cubit.sendMessage(),
            icon: const Icon(Icons.send),
          )),
    );
  }
}
