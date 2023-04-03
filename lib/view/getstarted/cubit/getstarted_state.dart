part of 'getstarted_cubit.dart';

abstract class GetstartedState extends Equatable {
  const GetstartedState();

  @override
  List<Object> get props => [];
}

class GetstartedInitial extends GetstartedState {}

class UploadFailure extends GetstartedState {
  final String message;

  const UploadFailure({required this.message});
}

class UploadSucess extends GetstartedState{}

class UploadLoading extends GetstartedState{}
