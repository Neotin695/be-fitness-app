import 'package:be_fitness_app/core/appconstance/media_constance.dart';
import 'package:be_fitness_app/view/home/cubit/home_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
      bottomNavigationBar: BottomNavigationBar(
        onTap: (i) => setState(() => cubit.changeIndex(i)),
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: cubit.index,
        items: [
          BottomNavigationBarItem(
              icon: SvgPicture.asset(MediaConst.home), label: ''),
          const BottomNavigationBarItem(
              icon: Icon(Icons.health_and_safety), label: ''),
          const BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.peopleGroup), label: ''),
          const BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.map), label: ''),
          const BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.message), label: ''),
          const BottomNavigationBarItem(icon: Icon(Icons.person), label: '')
        ],
      ),
      body: SafeArea(child: cubit.currentPage()),
    );
  }
}
