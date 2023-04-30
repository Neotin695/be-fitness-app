import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/verify_coach_view.dart';
import '../cubit/coach_cubit.dart';

class VerifyCoachPage extends StatefulWidget {
  static const String routeName = 'verifyCoachScreen';
  const VerifyCoachPage({super.key});

  @override
  State<VerifyCoachPage> createState() => _VerifyCoachPageState();
}

class _VerifyCoachPageState extends State<VerifyCoachPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: BlocProvider(
          create: (context) => CoachCubit(),
          child: const BodyVerifyCoach(),
        ));
  }
}
