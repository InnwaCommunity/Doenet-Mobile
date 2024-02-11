abstract class LoginEvent {}

class PerformLoginEvent extends LoginEvent {
  final String username;
  final String password;
  final String email;

  PerformLoginEvent({required this.username, required this.password,required this.email});
}


// abstract class LoginEvent {}

// class PerformLoginEvent extends LoginEvent {
//   final String username;
//   final String password;

//   PerformLoginEvent({required this.username, required this.password});
// }
