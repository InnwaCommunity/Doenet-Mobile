part of 'splash_state_management_bloc.dart';

abstract class SplashStateManagementEvent extends Equatable{
  const SplashStateManagementEvent();
  @override
  List<Object?> get props => [];
}

class CheckAutoLogin extends SplashStateManagementEvent{}
