import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'workout_state.dart';

class WorkoutCubit extends Cubit<WorkoutState> {
  static WorkoutCubit get(context) => BlocProvider.of(context);
  WorkoutCubit() : super(WorkoutInitial());
}
