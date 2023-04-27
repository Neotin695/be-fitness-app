import 'package:be_fitness_app/view/profile/screens/profile_page.dart';
import 'package:be_fitness_app/view/workout/screens/main_workout_page.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../chat/screens/message_page.dart';
import '../../verifycoach/screens/coachs_page.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  static HomeCubit get(context) => BlocProvider.of(context);
  HomeCubit() : super(HomeInitial());
  List<Widget> pages = [
    const MainWorkoutPage(),
    const CoachsPage(),
    const MessagePage(),
    const ProfilePage()
  ];

  Widget currentPage() {
    return pages[index];
  }

  void changeIndex(i) {
    index = i;
  }

  int index = 0;
}
