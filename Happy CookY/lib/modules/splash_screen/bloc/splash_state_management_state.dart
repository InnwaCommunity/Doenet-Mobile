part of 'splash_state_management_bloc.dart';


abstract class SplashStateManagementState extends Equatable{
  const SplashStateManagementState();
  @override
  List<Object?> get props => [];
}

final class SplashStateManagementInitial extends SplashStateManagementState {}

class AutoLoginSuccess extends SplashStateManagementState{}

class AutoLoginFail extends SplashStateManagementState{}
