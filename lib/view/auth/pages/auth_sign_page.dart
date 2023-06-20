import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../cubit/auth_cubit.dart';
import '../views/auth_signin_view.dart';

class AuthSignInPage extends StatefulWidget {
  static const String routeName = '/signIn';
  const AuthSignInPage({super.key});

  @override
  State<AuthSignInPage> createState() => _AuthSignInPageState();
}

class _AuthSignInPageState extends State<AuthSignInPage> {
  bool isMute = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => AuthCubit(),
        child: const AuthSignInView(),
      ),
    );
  }
}
