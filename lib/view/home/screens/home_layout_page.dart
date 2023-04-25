import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../chat/screens/message_page.dart';
import '../../verifycoach/screens/coachs_page.dart';

class HomeLayoutPage extends StatefulWidget {
  static const String routeName = 'homeLayour';
  const HomeLayoutPage({super.key});

  @override
  State<HomeLayoutPage> createState() => _HomeLayoutPageState();
}

class _HomeLayoutPageState extends State<HomeLayoutPage> {
  static const List<Widget> pages = [
    const CoachsPage(),
    const MessagePage(),
  ];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => FirebaseAuth.instance.signOut(),
              icon: const Icon(Icons.logout))
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (i) {
          setState(() {
            index = i;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '')
        ],
      ),
      body: pages[index],
    );
  }
}
