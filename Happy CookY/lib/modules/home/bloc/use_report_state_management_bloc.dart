import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:register_customer/config/Sharef/share_pref.dart';
import 'package:register_customer/constants/constants.dart';
import 'package:register_customer/model/use_report_model.dart';
import 'package:register_customer/model/user_data_model.dart';
import 'package:register_customer/modules/home/repository/home_screen_repository.dart';

part 'use_report_state_management_event.dart';
part 'use_report_state_management_state.dart';

class UseReportStateManagementBloc extends Bloc<UseReportStateManagementEvent, UseReportStateManagementState> {
  final HomeScreenRepository homeScreenRepository;
  UseReportStateManagementBloc(this.homeScreenRepository) : super(UseReportStateManagementInitial()) {
    int page=0;
    int userpage=0;
    on<UseReportStateManagementEvent>((event, emit) {});

    on<LoadUseReportList>((event, emit) async{
      String categoryidval=event.categoryIdval;
        var userInfo = await SharedPref.getStringList(key: shploginInfo);
        if (userInfo != null && userInfo.isNotEmpty) {
          String userId = userInfo[2];
          var res = await homeScreenRepository.getUseReportList(userId, categoryidval,page);
          if (res != 'false') {
            var data=jsonDecode(res);
            List<UseReportDetailModel> useReportList =
                (data as List).map((e) => UseReportDetailModel.fromJson(e)).toList();
            emit(LoadUseReportSuccess(useReportList: useReportList));
          }else{
            emit(UseReportBlocError(error: res));
          }
        }
    },);

    on<SaveUseReportEvent>((event, emit) async{
      var userInfo = await SharedPref.getStringList(key: shploginInfo);
        if (userInfo != null && userInfo.isNotEmpty) {
          String userId = userInfo[2];
          var res = await homeScreenRepository.saveUseReport(userId,event.useAmount,event.description, event.categoryid);
          if (res != 'false' && res == 'Save Successfully') {
            emit(SaveUseReportSuccess(message: res));
          }else{
            emit(UseReportBlocError(error: res));
          }
        }
    });

    on<FrashUserList>((event,emit) async{
      String username=event.userdata;
      String categoryidval=event.categoryIdval;
      var userInfo = await SharedPref.getStringList(key: shploginInfo);
        if (userInfo != null && userInfo.isNotEmpty) {
          String userId = userInfo[2];
          var res = await homeScreenRepository.getUserListInCluster(userId,categoryidval,userpage,username);
          if (res != 'false') {
            var data=jsonDecode(res);
            List<UserData> userDatas= (data as List).map((e) => UserData.fromJson(e)).toList();
            emit(FrashUserListSuccess(userDatas: userDatas));
          }else{
            emit(UseReportBlocError(error: res));
          }
        }
    });
  }
}
