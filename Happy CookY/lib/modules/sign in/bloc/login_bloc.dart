
import 'package:register_customer/modules/sign%20in/repository/login_repository.dart';

import 'login_event.dart';
import 'login_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository loginRepository;
  LoginBloc(this.loginRepository) : super(InitialLoginState()) {
    on<PerformLoginEvent>((event, emit) async {
      emit(InitialLoginState());
      String username=event.username;
      String password=event.password;
      String email=event.email;
      if (username.isNotEmpty && password.isNotEmpty) {
        String res= await loginRepository.login(username,email, password);
       if (res != 'false' && res == 'trueuser') {
          emit(SuccessLoginState());
        }else{
          emit(FailureLoginState(errorMessage: 'Invalid username or password.'));
        }
      } else {
        if (username.isEmpty) {
          emit(NeedToAddUserName());
        } else if(password.isEmpty){
          emit(NeedToAddPassword());
        }
      }
    });
  }
}

// class LoginBloc extends Bloc<LoginEvent, LoginState> {
//   final ApiService apiService;
//   final String baseUrl = 'https://192.168.100.21:7034/api';

//   LoginBloc({required this.apiService}) : super(InitialLoginState());

//   @override
//   Stream<LoginState> mapEventToState(LoginEvent event) async* {
//     if (event is PerformLoginEvent) {
//       yield LoadingLoginState();

//       Map<String, String> loginRequestHeader = {};
//       Map<String, dynamic> loginRequestBody = {
//         'LoginType': '1',
//         'username': event.username,
//         'password': event.password,
//       };
//       print(loginRequestBody);
//       try {
//         LoginDataModel loginDataModel = await apiService.postAuthData(
//             '$baseUrl/token', loginRequestHeader, loginRequestBody);
//         if (loginDataModel.displayName == null) {
//           yield FailureLoginState(
//               errorMessage: 'Invalid username or password.');
//         } else {
//           yield SuccessLoginState();
//         }
//       } catch (e) {
//         yield FailureLoginState(
//             errorMessage: 'An error occurred while trying to log in.');
//       }
//     }
//   }
// }

// class LoginBloc {
//   final ApiService apiService;
//   final String baseUrl = 'https://192.168.100.21:7034/api';
//   LoginBloc({required this.apiService});

//   final _loginStateController = StreamController<LoginState>();
//   Stream<LoginState> get loginStateStream => _loginStateController.stream;

//   void dispose() {
//     _loginStateController.close();
//   }

//   void performLogin(String username, String password) async {
//     Map<String, String> loginRequestHeader = {};
//     Map<String, dynamic> loginRequestBody = {
//       'LoginType': '1',
//       'username': username, // 'moemoe'
//       'password': password, // 'moemoe'
//       // 'GrantType': 'password'
//     };

//     _loginStateController.add(LoadingLoginState());

//     try {
//       LoginDataModel loginDataModel = await apiService.postAuthData(
//           '$baseUrl/token', loginRequestHeader, loginRequestBody);
//       if (loginDataModel.displayName == null) {
//         _loginStateController.add(
//             FailureLoginState(errorMessage: 'Invalid username or password.'));
//       } else {
//         _loginStateController.add(SuccessLoginState());
//       }
//     } catch (e) {
//       _loginStateController.add(FailureLoginState(
//           errorMessage: 'An error occurred while trying to log in.'));
//     }
//   }
// }
