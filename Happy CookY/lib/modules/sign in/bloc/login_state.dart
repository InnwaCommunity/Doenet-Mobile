abstract class LoginState {}

class InitialLoginState extends LoginState {}

class LoadingLoginState extends LoginState {}

class FailureLoginState extends LoginState {
  final String errorMessage;

  FailureLoginState({required this.errorMessage});
}

class SuccessLoginState extends LoginState {}

class NeedToAddUserName extends LoginState{}

class NeedToAddPassword extends LoginState{}