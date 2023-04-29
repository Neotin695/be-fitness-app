import 'package:be_fitness_app/view/getstarted/cubit/getstarted_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/create_profile_view.dart';

class CreateProfileScreen extends StatefulWidget {
  static const String routeName = 'createProfileScreen';
  const CreateProfileScreen({super.key});

  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => GetstartedCubit(),
        child: const CreateProfileView(),
      ),
    );
  }
}
