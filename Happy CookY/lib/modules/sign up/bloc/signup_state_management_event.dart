part of 'signup_state_management_bloc.dart';

abstract class SignupStateManagementEvent extends Equatable{
  const SignupStateManagementEvent();

  @override
  List<Object?> get props => [];
}

class CreateAccount extends SignupStateManagementEvent {
  final String username;
  final String email;
  final String password;
  final String confirmpassword;
  const CreateAccount(
      {required this.username,
      required this.email,
      required this.password,
      required this.confirmpassword});
  
  @override
  List<Object?> get props => [username,email,password,confirmpassword];
}
