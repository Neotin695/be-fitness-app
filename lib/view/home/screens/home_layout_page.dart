import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../verifycoach/screens/coachs_page.dart';

class HomeLayoutPage extends StatelessWidget {
  static const String routeName = 'homeLayour';
  const HomeLayoutPage({super.key});

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
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '')
        ],
      ),
      body: const CoachsPage(),
    );
  }
}
