import 'package:be_fitness_app/core/service/decisions_tree.dart';
import 'package:be_fitness_app/view/admin/pages/excercise_admin_page.dart';
import 'package:be_fitness_app/view/admin/pages/review_page.dart';
import 'package:be_fitness_app/view/auth/pages/auth_signup_page.dart';
import 'package:be_fitness_app/view/coach/pages/display_reviews_page.dart';
import 'package:be_fitness_app/view/health/pages/calc_calories_page.dart';
import 'package:be_fitness_app/view/onboarding/pages/on_boarding_page.dart';
import 'package:be_fitness_app/view/auth/pages/auth_sign_page.dart';
import 'package:be_fitness_app/view/chat/pages/chat_room_page.dart';
import 'package:be_fitness_app/view/coach/pages/details_coach_page.dart';
import 'package:be_fitness_app/view/getstarted/pages/create_profile_page.dart';
import 'package:be_fitness_app/view/getstarted/pages/getstarted_page.dart';
import 'package:be_fitness_app/view/home/pages/home_layout_page.dart';
import 'package:be_fitness_app/view/profile/page/profile_page.dart';
import 'package:be_fitness_app/view/coach/pages/create_coach_page.dart';
import 'package:be_fitness_app/view/workout/pages/play_excercise_page.dart';
import 'package:flutter/material.dart';

import '../../view/admin/pages/main_admin_page.dart';
import '../../view/coach/pages/add_review_page.dart';
import '../../view/musicplayer/pages/music_player_page.dart';
import '../../view/profile/page/update_profile_page.dart';
import '../../view/coach/pages/not_accepted_screen.dart';
import '../../view/workout/pages/excercises_page.dart';

class RouteGenerator {
  Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case DecisionsTree.routeName:
        return _pageRoute(const DecisionsTree());
      case OnBoardingPage.routeName:
        return _pageRoute(const OnBoardingPage());
      case MainAdminPage.routeName:
        return _pageRoute(const MainAdminPage());
      case ReviewPage.routeName:
        final arg = routeSettings.arguments;
        return _pageRoute(const ReviewPage(), arg);
      case AuthSignInPage.routeName:
        return _pageRoute(const AuthSignInPage());
      case AuthSignUpPage.routeName:
        return _pageRoute(const AuthSignUpPage());
      case GetStartedScreen.routeName:
        return _pageRoute(const GetStartedScreen());
      case CreateCoachPage.routeName:
        return _pageRoute(const CreateCoachPage());
      case CreateProfilePage.routeName:
        return _pageRoute(const CreateProfilePage());
      case CalcCaloriesPage.routeName:
        return _pageRoute(const CalcCaloriesPage());
      case NotAcceptedScreen.routeName:
        return _pageRoute(const NotAcceptedScreen());
      case MusicPlayerPage.routeName:
        final arg = routeSettings.arguments;
        return _pageRoute(const MusicPlayerPage(), arg);
      case AddReviewPage.routeName:
        final arg = routeSettings.arguments;
        return _pageRoute(const AddReviewPage(), arg);
      case DisplayReviewsPage.routeName:
        final arg = routeSettings.arguments;
        return _pageRoute(const DisplayReviewsPage(), arg);
      case HomeLayoutPage.routeName:
        return _pageRoute(const HomeLayoutPage());
      case ExcerciseAdminPage.routeName:
        return _pageRoute(const ExcerciseAdminPage());
      case ChatRoomPage.routeName:
        final arg = routeSettings.arguments;
        return _pageRoute(const ChatRoomPage(), arg);
      case ExcercisePage.routeName:
        final arg = routeSettings.arguments;
        return _pageRoute(const ExcercisePage(), arg);
      case PlayExcercisePage.routeName:
        final arg = routeSettings.arguments;
        return _pageRoute(const PlayExcercisePage(), arg);
      case ProfilePage.routeName:
        return _pageRoute(const ProfilePage());
      case UpdateProfilePage.routeName:
        final arg = routeSettings.arguments;
        return _pageRoute(const UpdateProfilePage(), arg);
      case DetailsCoachPage.routeName:
        final arg = routeSettings.arguments;
        return _pageRoute(const DetailsCoachPage(), arg);
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
