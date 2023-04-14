part of 'verifycoach_cubit.dart';

abstract class VerifyCoachState extends Equatable {
  const VerifyCoachState();

  @override
  List<Object> get props => [];
}

class VerifyCoachInitial extends VerifyCoachState {}

class ImgUploading extends VerifyCoachState {}

class ImgUploadFailure extends VerifyCoachState {
  final String message;
  const ImgUploadFailure({required this.message});
}

class ImgUploadSucess extends VerifyCoachState {}

class PickImageCancel extends VerifyCoachState {}

class PickImageSucess extends VerifyCoachState {}

class RequestSentSucess extends VerifyCoachState {}

class RequestSentFailure extends VerifyCoachState {
  final String message;
  const RequestSentFailure({required this.message});
}

class AceeptedState extends VerifyCoachState {}

class RejectState extends VerifyCoachState {}
