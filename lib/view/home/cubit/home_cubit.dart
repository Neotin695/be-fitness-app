import 'package:be_fitness_app/view/health/pages/health_page.dart';
import 'package:be_fitness_app/view/maps/pages/map_page.dart';
import 'package:be_fitness_app/view/profile/page/profile_page.dart';
import 'package:be_fitness_app/view/workout/pages/main_workout_page.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../chat/pages/message_page.dart';
import '../../coach/pages/coachs_page.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  static HomeCubit get(context) => BlocProvider.of(context);
  HomeCubit() : super(HomeInitial());
  List<Widget> pages = [
    const MainWorkoutPage(),
    const HealthPage(),
    const CoachsPage(),
    const MapPage(),
    const MessagePage(),
    const ProfilePage(),
  ];

  Widget currentPage() {
    return pages[index];
  }

  void changeIndex(i) {
    index = i;
  }

  int index = 0;
}
