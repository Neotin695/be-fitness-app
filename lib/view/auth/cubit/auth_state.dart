part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthFailure extends AuthState {
  final String message;

  const AuthFailure({required this.message});
}

class AuthSucess extends AuthState {
  final bool isNewUser;

  const AuthSucess({required this.isNewUser});
}

class AuthenticateState extends AuthState{}

class UnauthenticateState extends AuthState{}
