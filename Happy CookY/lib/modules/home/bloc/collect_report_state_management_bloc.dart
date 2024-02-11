import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:register_customer/config/Sharef/share_pref.dart';
import 'package:register_customer/constants/constants.dart';
import 'package:register_customer/model/collect_model.dart';
import 'package:register_customer/model/user_data_model.dart';
import 'package:register_customer/modules/home/repository/home_screen_repository.dart';

part 'collect_report_state_management_event.dart';
part 'collect_report_state_management_state.dart';

class CollectReportStateManagementBloc extends Bloc<
    CollectReportStateManagementEvent, CollectReportStateManagementState> {
  final HomeScreenRepository homeScreenRepository;
  CollectReportStateManagementBloc(this.homeScreenRepository)
      : super(CollectReportStateManagementInitial()) {
    int collpage = 0;
    int userpage = 0;
    on<CollectReportStateManagementEvent>((event, emit) {});

    on<GetPossessValue>((event, emit) async {
      String categoryIdval = event.categoryIdval;
      var userInfo = await SharedPref.getStringList(key: shploginInfo);
      if (userInfo != null && userInfo.isNotEmpty) {
        String userId = userInfo[2];
        String res =
            await homeScreenRepository.getPossessValue(userId, categoryIdval);
        if (res != 'false') {
          var resData = jsonDecode(res);
          if (resData != false && resData['status'] == 1) {
            emit(CollectReportSuccess(
                total: resData['Total'],
                possessValue: resData['PossessValue']));
          } else {
            emit(CollectReportError(error: resData['error']));
          }
        } else {
          emit(CollectReportError(error: res));
        }
      }
    });

    on<GetCollectReportList>((event, emit) async {
      String categoryIdval = event.categoryIdval;
      var userInfo = await SharedPref.getStringList(key: shploginInfo);
      if (userInfo != null && userInfo.isNotEmpty) {
        String userId = userInfo[2];
        String res = await homeScreenRepository.getCollectReportList(
            userId, categoryIdval, collpage);
        if (res != 'false') {
          var resData = jsonDecode(res);
          if (resData != false && resData['status'] == 1) {
            List<CollectDatas> collectDatas = (resData['data'] as List)
                .map((e) => CollectDatas.fromJson(e))
                .toList();
            emit(LoadedCollectReport(collectDatas: collectDatas));
          } else {
            emit(CollectReportError(error: resData['error']));
          }
        } else {
          emit(CollectReportError(error: res));
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
            emit(CollectReportError(error: res));
          }
        }
    });
  }
}
