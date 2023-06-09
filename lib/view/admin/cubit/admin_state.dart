// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'admin_cubit.dart';

abstract class AdminState extends Equatable {
  const AdminState();

  @override
  List<Object> get props => [];
}

class AdminInitial extends AdminState {}

class FetchRequestsState extends AdminState {
  final List<RequestOnlineCoachModel> requests;
  const FetchRequestsState({
    required this.requests,
  });
}

class FailureState extends AdminState {
  final String message;
  const FailureState({
    required this.message,
  });
}

class AccepteRequest extends AdminState {}

class RejectRequest extends AdminState {}

class LoadingRequestState extends AdminState {}

class UploadingExcercise extends AdminState {}

class UploadedExcercise extends AdminState {}
