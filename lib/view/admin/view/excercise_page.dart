import 'package:be_fitness_app/view/admin/cubit/admin_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/excercise_view.dart';

class ExcercisePage extends StatelessWidget {
  static const String routeName = '/exercise';
  const ExcercisePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Excercise'),
      ),
      body: BlocProvider(
        create: (context) => AdminCubit(),
        child: const ExcerciseView(),
      ),
    );
  }
}
