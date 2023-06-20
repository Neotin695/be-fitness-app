import 'package:be_fitness_app/view/coach/cubit/coach_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../views/coachs_view.dart';

class CoachsPage extends StatelessWidget {
  const CoachsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Fitness Trainers'),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => CoachCubit(),
        child: const CoachsView(),
      ),
    );
  }
}
