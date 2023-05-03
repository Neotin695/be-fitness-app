import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/page_view_model.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  static OnboardingCubit get(context) => BlocProvider.of(context);
  OnboardingCubit() : super(OnboardingInitial());

  int index = 0;

  List<PageViewModel> listData() {
    return [
      PageViewModel(
        title: 'MEET YOUR COACH,\n START YOUR JOURNEY',
        image: 'assets/images/khaled.jpg',
      ),
      PageViewModel(
        title: 'CREATE A WORKOUT PLAN \n TO STAY FIT',
        image: 'assets/images/background_onboarding2.png',
      ),
      PageViewModel(
        title: 'ACTION IS THE\n KEY TO ALL SUCCESS',
        image: 'assets/images/background_onboarding3.png',
      ),
    ];
  }

  void onPageChange(value) {
    index = value;
  }
}
