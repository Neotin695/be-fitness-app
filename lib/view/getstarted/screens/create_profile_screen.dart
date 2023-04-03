import 'package:be_fitness_app/view/getstarted/cubit/getstarted_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/body_getstarted.dart';

class CreateProfileScreen extends StatelessWidget {
  static const String routeName = 'createProfileScreen';
  const CreateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => GetstartedCubit(),
        child: const BodyStarted(),
      ),
    );
  }
}
