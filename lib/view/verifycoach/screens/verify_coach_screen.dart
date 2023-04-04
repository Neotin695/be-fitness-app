import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/verifycoach_cubit.dart';

class VerifyCoachScreen extends StatelessWidget {
  static const String routeName = 'verifyCoachScreen';
  const VerifyCoachScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => VerifyCoachCubit(),
        child: Container(),
      )
    );
  }
}
