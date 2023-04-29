part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class UploadingDataState extends ProfileState {}

class UploadFailureState extends ProfileState {
  final String message;
  const UploadFailureState({required this.message});
}

class UploadSuccess extends ProfileState {}
