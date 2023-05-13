part of 'health_cubit.dart';

abstract class HealthState extends Equatable {
  const HealthState();

  @override
  List<Object> get props => [];
}

class HealthInitial extends HealthState {}

class NutrientLoaded extends HealthState {}

class ErrorState extends HealthState {
  final String message;
  const ErrorState({required this.message});
}

class NutrientNotFound extends HealthState {}

class LoadingState extends HealthState {}
