import 'package:be_fitness_app/view/admin/cubit/admin_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/excercise_view.dart';

class ExcerciseAdminPage extends StatelessWidget {
  static const String routeName = '/exerciseAdminPage';
  const ExcerciseAdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Excercise'),
      ),
      body: BlocProvider(
        create: (context) => AdminCubit(),
        child: const ExcerciseAdminView(),
      ),
    );
  }
}
