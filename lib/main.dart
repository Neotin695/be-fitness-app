import 'package:be_fitness_app/core/service/decisions_tree.dart';
import 'package:be_fitness_app/view/admin/view/body_part_page.dart';
import 'package:be_fitness_app/view/admin/view/excercise_page.dart';
import 'package:be_fitness_app/view/admin/view/main_admin_page.dart';
import 'package:be_fitness_app/view/admin/view/review_page.dart';
import 'package:be_fitness_app/view/auth/screens/welcome_screen.dart';
import 'package:be_fitness_app/view/chat/screens/chat_room_page.dart';
import 'package:be_fitness_app/view/getstarted/screens/create_profile_screen.dart';
import 'package:be_fitness_app/view/getstarted/screens/getstarted_screen.dart';
import 'package:be_fitness_app/view/home/screens/home_layout_page.dart';
import 'package:be_fitness_app/view/verifycoach/screens/not_accepted_screen.dart';
import 'package:be_fitness_app/view/verifycoach/screens/verify_coach_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
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
        builder: (context, child) {
          return ResponsiveWrapper.builder(child,
              maxWidth: 1200,
              minWidth: 480,
              defaultScale: true,
              breakpoints: [
                const ResponsiveBreakpoint.resize(480, name: MOBILE),
                const ResponsiveBreakpoint.autoScale(800, name: TABLET),
                const ResponsiveBreakpoint.resize(1000, name: DESKTOP),
              ],
              background: Container(color: const Color(0xFFF5F5F5)));
        },
        initialRoute: '/',
        routes: {
          '/': (_) => const DecisionsTree(),
          MainAdminPage.routeName: (_) => const MainAdminPage(),
          ReviewPage.routeName: (_) => const ReviewPage(),
          WelcomeScreen.routeName: (_) => const WelcomeScreen(),
          GetStartedScreen.routeName: (_) => const GetStartedScreen(),
          VerifyCoachScreen.routeName: (_) => const VerifyCoachScreen(),
          CreateProfileScreen.routeName: (_) => const CreateProfileScreen(),
          NotAcceptedScreen.routeName: (_) => const NotAcceptedScreen(),
          HomeLayoutPage.routeName: (_) => const HomeLayoutPage(),
          BodyPartPage.routeName: (_) => const BodyPartPage(),
          ExcercisePage.routeName: (_) => const ExcercisePage(),
          ChatRoomPage.routeName: (_)=> const ChatRoomPage(),
        },
      );
    });
  }
}
