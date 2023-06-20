import 'package:be_fitness_app/view/health/cubit/health_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../views/calc_calories_view.dart';

class CalcCaloriesPage extends StatelessWidget {
  static const String routeName = '/calcCalories';
  const CalcCaloriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'BMR CALCULATOR',
        ),
      ),
      body: BlocProvider(
        create: (_) => HealthCubit(),
        child: const CalcCaloriesView(),
      ),
    );
  }
}
