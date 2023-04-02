import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'verifycoach_state.dart';

class VerifycoachCubit extends Cubit<VerifycoachState> {
  VerifycoachCubit() : super(VerifycoachInitial());
}
