import 'package:be_fitness_app/view/chat/cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class InputMessage extends StatelessWidget {
  final ChatCubit cubit;
  const InputMessage({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
      child: TextField(
        controller: cubit.message,
        style: Theme.of(context).textTheme.bodyMedium,
        decoration: InputDecoration(
            hintText: 'Type a message...',
            border: InputBorder.none,
            suffix: IconButton(
              onPressed: () async => await cubit.sendMessage(),
              icon: const Icon(Icons.send),
            )),
      ),
    );
  }
}
