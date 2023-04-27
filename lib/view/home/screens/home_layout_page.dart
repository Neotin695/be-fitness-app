import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../chat/screens/message_page.dart';
import '../../verifycoach/screens/coachs_page.dart';
import '../components/home_layout_view.dart';
import '../cubit/home_cubit.dart';

class HomeLayoutPage extends StatefulWidget {
  static const String routeName = 'homeLayour';
  const HomeLayoutPage({super.key});

  @override
  State<HomeLayoutPage> createState() => _HomeLayoutPageState();
}

class _HomeLayoutPageState extends State<HomeLayoutPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: const HomeLayoutView(),
    );
  }
}
