
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:register_customer/config/Sharef/share_pref.dart';
import 'package:register_customer/constants/constants.dart';
import 'package:register_customer/modules/sign%20in/repository/login_repository.dart';

part 'splash_state_management_event.dart';
part 'splash_state_management_state.dart';

class SplashStateManagementBloc extends Bloc<SplashStateManagementEvent, SplashStateManagementState> {
  final LoginRepository loginRepository;
  SplashStateManagementBloc(this.loginRepository) : super(SplashStateManagementInitial()) {
    on<SplashStateManagementEvent>((event, emit) {});

    on<CheckAutoLogin>((event, emit) async{
      List<String>? loginInf= await SharedPref.getStringList(key: shploginInfo);
      String? username=loginInf?.first;
      String? email=loginInf?[1];
      String? password= loginInf?.last;
      if (username != null && password != null && email != null) {
        var res= await loginRepository.login(username, email, password);
        if (res != 'false' && res == 'trueuser') {
          emit(AutoLoginSuccess());
        }else{
          emit(AutoLoginFail());
        }
      } else {
        emit(AutoLoginFail());
      }
    },);
  }
}
