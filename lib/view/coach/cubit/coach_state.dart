part of 'coach_cubit.dart';

abstract class CoachState extends Equatable {
  const CoachState();

  @override
  List<Object> get props => [];
}

class CoachInitial extends CoachState {}

class ImgUploading extends CoachState {}

class ImgUploadFailure extends CoachState {
  final String message;
  const ImgUploadFailure({required this.message});
}

class ImgUploadSucess extends CoachState {}

class PickImageCancel extends CoachState {}

class PickImageSucess extends CoachState {}

class RequestSentSucess extends CoachState {}

class RequestSentFailure extends CoachState {
  final String message;
  const RequestSentFailure({required this.message});
}

class AceeptedState extends CoachState {}

class RejectState extends CoachState {}
