import 'package:be_fitness_app/view/admin/components/main_admin_view.dart';
import 'package:be_fitness_app/view/admin/cubit/admin_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/drawer.dart';

class MainAdminPage extends StatelessWidget {
  static const String routeName = '/mainAdminPage';
  const MainAdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerAdmin(),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => FirebaseAuth.instance.signOut(),
              icon: const Icon(Icons.logout))
        ],
      ),
      body: BlocProvider(
        lazy: false,
        create: (context) => AdminCubit(),
        child: const MainAdminView(),
      ),
    );
  }
}
