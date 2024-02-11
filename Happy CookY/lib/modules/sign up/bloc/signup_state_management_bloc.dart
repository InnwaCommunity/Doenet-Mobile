import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:register_customer/modules/sign%20in/repository/login_repository.dart';
import 'package:register_customer/modules/sign%20up/repository/sign_up_repository.dart';
import 'package:register_customer/services/function_service.dart';

part 'signup_state_management_event.dart';
part 'signup_state_management_state.dart';

class SignupStateManagementBloc
    extends Bloc<SignupStateManagementEvent, SignupStateManagementState> {
  final LoginRepository loginRepository;
  final SignUpRepository signUpRepository;
  SignupStateManagementBloc(this.loginRepository, this.signUpRepository)
      : super(SignupStateManagementInitial()) {
    on<SignupStateManagementEvent>((event, emit) {});

    on<CreateAccount>(
      (event, emit) async {
        String username = event.username;
        String email = event.email;
        String password = event.password;
        String confirmpassword = event.confirmpassword;
        if (username.isNotEmpty &&
            email.isNotEmpty &&
            password.isNotEmpty &&
            confirmpassword.isNotEmpty) {
          if (validateEmail(email: email)) {
            if (password == confirmpassword &&
                password.length > 8 &&
                passwordValidationUpperCase(password) &&
                passwordValidationLowerCase(password) &&
                passwordValidationNumeric(password) &&
                passwordValidationSpecialCharacter(password)) {
                var res = await signUpRepository.signup(
                    username: username, email: email, password: password);
                if (res != 'false' && res.toString().toLowerCase()== 'created successfully') {
                  var logres= await loginRepository.login(username,email,password);
                  if (logres != 'false') {
                    emit(CreateAccountSuccess());
                  } else {
                    emit(const CreateAccountFail(error: 'Invalid'));
                  }
                } else {
                  emit(const CreateAccountFail(error: 'Invalid'));
                }
            } else {
              if (password == confirmpassword) {
                emit(const CreateAccountFail(error: 'Password is not match'));
              } else if (password.length < 8) {
                emit(const CreateAccountFail(
                    error: 'Please add Minimum 8 characters'));
              } else if (!passwordValidationUpperCase(password)) {
                emit(const CreateAccountFail(
                    error: 'Please add at least one upper case'));
              } else if (!passwordValidationLowerCase(password)) {
                emit(const CreateAccountFail(
                    error: 'Please add at least one lower case'));
              } else if (!passwordValidationNumeric(password)) {
                emit(const CreateAccountFail(
                    error: 'Please add at least one numeric value'));
              } else {
                emit(const CreateAccountFail(
                    error: 'Please add at least one special character'));
              }
            }
          } else {
            emit(const CreateAccountFail(error: 'Email is validate format'));
          }
        } else {
          if (username.isEmpty) {
            emit(const CreateAccountFail(error: 'Please add user name'));
          } else if (email.isEmpty) {
            emit(const CreateAccountFail(error: 'Please add email'));
          } else {
            emit(const CreateAccountFail(error: 'Please add password'));
          }
        }
      },
    );
  }
}
