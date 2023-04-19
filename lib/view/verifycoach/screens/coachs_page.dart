import 'package:be_fitness_app/view/verifycoach/cubit/verifycoach_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/coachs_view.dart';

class CoachsPage extends StatelessWidget {
  const CoachsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => VerifyCoachCubit(),
        child: const CoachsView(),
      ),
    );
  }
}
