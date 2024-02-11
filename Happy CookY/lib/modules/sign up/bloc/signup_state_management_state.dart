part of 'signup_state_management_bloc.dart';

abstract class SignupStateManagementState extends Equatable{
  const SignupStateManagementState();
  @override
  List<Object?> get props => [];
}

final class SignupStateManagementInitial extends SignupStateManagementState {}

class CreateAccountFail extends SignupStateManagementState{
  final String error;
  const CreateAccountFail({required this.error});
  @override
  List<Object?> get props => [error];
}

class CreateAccountSuccess extends SignupStateManagementState{}
