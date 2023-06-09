import 'package:be_fitness_app/view/workout/cubit/workout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../views/excercises_view.dart';

class ExcercisePage extends StatelessWidget {
  static const String routeName = '/excercise';
  const ExcercisePage({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as List<dynamic>;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Excercises'),
        backgroundColor: Colors.transparent,
      ),
      body: BlocProvider(
        create: (context) => WorkoutCubit(),
        child: ExcerciseView(arguments: arguments),
      ),
    );
  }
}
