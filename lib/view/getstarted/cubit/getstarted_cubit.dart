import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'getstarted_state.dart';

class GetstartedCubit extends Cubit<GetstartedState> {
  GetstartedCubit() : super(GetstartedInitial());
}
