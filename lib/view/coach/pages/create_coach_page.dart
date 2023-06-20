import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../views/create_coach_view.dart';
import '../cubit/coach_cubit.dart';

class CreateCoachPage extends StatefulWidget {
  static const String routeName = 'verifyCoachScreen';
  const CreateCoachPage({super.key});

  @override
  State<CreateCoachPage> createState() => _CreateCoachPageState();
}

class _CreateCoachPageState extends State<CreateCoachPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: BlocProvider(
          create: (context) => CoachCubit(),
          child: const CreateCoachView(),
        ));
  }
}
