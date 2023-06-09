import 'package:be_fitness_app/view/onboarding/cubit/onboarding_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../views/onboarding_view.dart';

class OnBoardingPage extends StatefulWidget {
  static const String routeName = '/onboaring';

  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (_) => OnboardingCubit(),
      child: const OnboardingView(),
    ));
  }
}
