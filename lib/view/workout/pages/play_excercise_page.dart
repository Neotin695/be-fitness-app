import 'package:be_fitness_app/models/excercise_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../views/play_excercise_view.dart';
import '../cubit/workout_cubit.dart';

class PlayExcercisePage extends StatelessWidget {
  static const String routeName = '/playExcercise';
  const PlayExcercisePage({super.key});

  @override
  Widget build(BuildContext context) {
    final excercise =
        ModalRoute.of(context)!.settings.arguments as ExcerciseModel;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(excercise.name),
      ),
      body: BlocProvider(
        create: (context) => WorkoutCubit(),
        child: PlayExcerciseView(excercise: excercise),
      ),
    );
  }
}
