import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/main_workout_view.dart';
import '../cubit/workout_cubit.dart';

class MainWorkoutPage extends StatelessWidget {
  const MainWorkoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => WorkoutCubit(),
        child: const MainWorkoutView(),
      ),
    );
  }
}
