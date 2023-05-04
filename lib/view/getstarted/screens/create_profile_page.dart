import 'package:be_fitness_app/view/getstarted/cubit/getstarted_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/create_profile_view.dart';

class CreateProfilePage extends StatefulWidget {
  static const String routeName = 'createProfileScreen';
  const CreateProfilePage({super.key});

  @override
  State<CreateProfilePage> createState() => _CreateProfilePageState();
}

class _CreateProfilePageState extends State<CreateProfilePage> {
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
