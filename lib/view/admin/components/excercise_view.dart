import 'package:be_fitness_app/view/admin/cubit/admin_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExcerciseView extends StatelessWidget {
  const ExcerciseView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AdminCubit,AdminState>(
      listener: (context, state) {
        
      },
      child: Column(
        children: [
          
        ],
      ),
    );
  }
}