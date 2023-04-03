import 'package:be_fitness_app/core/service/decisions_tree.dart';
import 'package:be_fitness_app/view/getstarted/screens/create_profile_screen.dart';
import 'package:be_fitness_app/view/getstarted/screens/getstarted_screen.dart';
import 'package:be_fitness_app/view/home/screens/home_layout.dart';
import 'package:be_fitness_app/view/verifycoach/screens/verify_coach_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:sizer/sizer.dart';

import 'core/service/firebase/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainWidget());
}

class MainWidget extends StatelessWidget {
  const MainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.indigo,
        ),
        navigatorObservers: [FlutterSmartDialog.observer],
        builder: FlutterSmartDialog.init(),
        initialRoute: DecisionsTree.routeName,
        routes: {
          GetStartedScreen.routeName: (_) => const GetStartedScreen(),
          VerifyCoachScreen.routeName: (_) => const VerifyCoachScreen(),
          CreateProfileScreen.routeName: (_) => const CreateProfileScreen(),
          HomeLayoutScreen.routeName: (_) => const HomeLayoutScreen(),
          DecisionsTree.routeName: (_) => const DecisionsTree(),
        },
      );
    });
  }
}
