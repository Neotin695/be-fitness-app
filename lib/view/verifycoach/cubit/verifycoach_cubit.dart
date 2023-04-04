// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'verifycoach_state.dart';

class VerifyCoachCubit extends Cubit<VerifyCoachState> {
  VerifyCoachCubit() : super(VerifyCoachInitial());
}
