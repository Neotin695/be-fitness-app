import 'package:be_fitness_app/view/health/cubit/health_cubit.dart';
import 'package:be_fitness_app/view/health/view/calc_calories_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/health_view.dart';

class HealthPage extends StatelessWidget {
  static const String routeName = '/health';
  const HealthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: 'calc',
        onPressed: () {
          Navigator.pushNamed(context, CalcCaloriesPage.routeName);
        },
        child: const Icon(Icons.calculate),
      ),
      body: BlocProvider(
        create: (_) => HealthCubit(),
        child: const HealthView(),
      ),
    );
  }
}
