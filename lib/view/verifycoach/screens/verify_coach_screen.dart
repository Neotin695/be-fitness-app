import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/body_verify_coach.dart';
import '../cubit/verifycoach_cubit.dart';

class VerifyCoachScreen extends StatefulWidget {
  static const String routeName = 'verifyCoachScreen';
  const VerifyCoachScreen({super.key});

  @override
  State<VerifyCoachScreen> createState() => _VerifyCoachScreenState();
}

class _VerifyCoachScreenState extends State<VerifyCoachScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: BlocProvider(
          create: (context) => VerifyCoachCubit(),
          child: const BodyVerifyCoach(),
        ));
  }

  
}
