import 'package:be_fitness_app/view/home/cubit/home_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeLayoutView extends StatefulWidget {
  const HomeLayoutView({super.key});

  @override
  State<HomeLayoutView> createState() => _HomeLayoutViewState();
}

class _HomeLayoutViewState extends State<HomeLayoutView> {
  @override
  Widget build(BuildContext context) {
    HomeCubit cubit = HomeCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('BE FITNESS'),
        actions: [
          IconButton(
              onPressed: () => FirebaseAuth.instance.signOut(),
              icon: const Icon(Icons.logout))
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (i) => setState(() => cubit.changeIndex(i)),
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: cubit.index,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.house), label: ''),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.peopleGroup), label: ''),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.map), label: ''),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.message), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '')
        ],
      ),
      body: cubit.currentPage(),
    );
  }
}
