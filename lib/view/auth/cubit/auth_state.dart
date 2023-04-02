part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthFailure extends AuthState {
  final String messsage;

  const AuthFailure({required this.messsage});
}

class AuthSucess extends AuthState {
  final bool isNewUser;

  const AuthSucess({required this.isNewUser});
}
