import 'package:be_fitness_app/core/service/decisions_tree.dart';
import 'package:be_fitness_app/models/excercise_model.dart';
import 'package:be_fitness_app/view/admin/view/excercise_admin_page.dart';
import 'package:be_fitness_app/view/admin/view/review_page.dart';
import 'package:be_fitness_app/view/auth/screens/welcome_screen.dart';
import 'package:be_fitness_app/view/chat/screens/chat_room_page.dart';
import 'package:be_fitness_app/view/getstarted/screens/create_profile_page.dart';
import 'package:be_fitness_app/view/getstarted/screens/getstarted_page.dart';
import 'package:be_fitness_app/view/home/screens/home_layout_page.dart';
import 'package:be_fitness_app/view/profile/screens/profile_page.dart';
import 'package:be_fitness_app/view/verifycoach/screens/verify_coach_screen.dart';
import 'package:be_fitness_app/view/workout/screens/play_excercise_page.dart';
import 'package:flutter/material.dart';

import '../../view/admin/view/main_admin_page.dart';
import '../../view/verifycoach/screens/not_accepted_screen.dart';
import '../../view/workout/screens/excercises_page.dart';

class RouteGenerator {
  Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case DecisionsTree.routeName:
        return _pageRoute(const DecisionsTree());
      case MainAdminPage.routeName:
        return _pageRoute(const MainAdminPage());
      case ReviewPage.routeName:
        return _pageRoute(const ReviewPage());
      case WelcomeScreen.routeName:
        return _pageRoute(const WelcomeScreen());
      case GetStartedScreen.routeName:
        return _pageRoute(const GetStartedScreen());
      case VerifyCoachScreen.routeName:
        return _pageRoute(const VerifyCoachScreen());
      case CreateProfileScreen.routeName:
        return _pageRoute(const CreateProfileScreen());
      case NotAcceptedScreen.routeName:
        return _pageRoute(const NotAcceptedScreen());
      case HomeLayoutPage.routeName:
        return _pageRoute(const HomeLayoutPage());
      case ExcerciseAdminPage.routeName:
        return _pageRoute(const ExcerciseAdminPage());
      case ChatRoomPage.routeName:
        final arg = routeSettings.arguments as String;
        return _pageRoute(const ChatRoomPage(), arg);
      case ExcercisePage.routeName:
        final arg = routeSettings.arguments as List<dynamic>;
        return _pageRoute(const ExcercisePage(), arg);
      case PlayExcercisePage.routeName:
        final arg = routeSettings.arguments as ExcerciseModel;
        return _pageRoute(const PlayExcercisePage(), arg);
      case ProfilePage.routeName:
        return _pageRoute(const ProfilePage());
      default:
        return _errorRoute();
    }
  }

  Route _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error Screen'),
        ),
        body: const Center(
          child: Text('somthing went wrong!'),
        ),
      );
    });
  }

  MaterialPageRoute _pageRoute(page, [arg]) {
    return MaterialPageRoute(
        builder: (context) => page, settings: RouteSettings(arguments: arg));
  }
}
