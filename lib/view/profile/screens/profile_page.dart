import 'package:be_fitness_app/view/profile/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'decision_profile.dart';

class ProfilePage extends StatelessWidget {
  static const String routeName = '/profilePage';
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => ProfileCubit(),
        child: const DecisionProfile(),
      ),
    );
  }
}
