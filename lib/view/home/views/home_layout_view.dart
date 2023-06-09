import 'package:be_fitness_app/core/appconstance/media_constance.dart';
import 'package:be_fitness_app/view/home/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
              icon: SvgPicture.asset(
                MediaConst.home,
                colorFilter:
                    const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
              ),
              label: ''),
          const BottomNavigationBarItem(
              icon: Icon(Icons.health_and_safety), label: ''),
          const BottomNavigationBarItem(icon: Icon(Icons.group), label: ''),
          const BottomNavigationBarItem(icon: Icon(Icons.map), label: ''),
          const BottomNavigationBarItem(icon: Icon(Icons.message), label: ''),
          const BottomNavigationBarItem(icon: Icon(Icons.person), label: '')
        ],
      ),
      body: SafeArea(child: cubit.currentPage()),
    );
  }
}
