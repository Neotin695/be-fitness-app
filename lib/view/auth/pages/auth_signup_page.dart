import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/auth_cubit.dart';
import '../views/auth_signup_view.dart';

class AuthSignUpPage extends StatefulWidget {
  static const String routeName = '/signUp';
  const AuthSignUpPage({super.key});

  @override
  State<AuthSignUpPage> createState() => _AuthSignUpPageState();
}

class _AuthSignUpPageState extends State<AuthSignUpPage> {
  bool isMute = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => AuthCubit(),
        child: const AuthSignUpView(),
      ),
    );
  }
}
