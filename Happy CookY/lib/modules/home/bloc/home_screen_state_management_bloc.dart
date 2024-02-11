import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:register_customer/config/Sharef/share_pref.dart';
import 'package:register_customer/constants/constants.dart';
import 'package:register_customer/model/category_model.dart';
import 'package:register_customer/model/clustermodel.dart';
import 'package:register_customer/modules/home/repository/home_screen_repository.dart';

part 'home_screen_state_management_event.dart';
part 'home_screen_state_management_state.dart';

class HomeScreenStateManagementBloc extends Bloc<HomeScreenStateManagementEvent,
    HomeScreenStateManagementState> {
  final HomeScreenRepository homeScreenRepository;
  HomeScreenStateManagementBloc(this.homeScreenRepository)
      : super(HomeScreenStateManagementInitial()) {
    on<HomeScreenStateManagementEvent>((event, emit) {});

    on<LoadClusterLists>(
      (event, emit) async {
        var userInfo = await SharedPref.getStringList(key: shploginInfo);
        if (userInfo != null && userInfo.isNotEmpty) {
          String userId = userInfo[2];
          if (userId.isNotEmpty) {
            var res = await homeScreenRepository.fetchClusterLists(userId);
            if (res != 'false') {
            var data=jsonDecode(res);
            List<ClusterModel> clusterList =
                (data as List).map((e) => ClusterModel.fromJson(e)).toList();
            emit(LoadClusterSuccess(clusterList: clusterList));
            }
          } else {
            emit(const LoadClusterError(
                error: 'Please Logout and Login to account'));
          }
        } else {
          emit(const LoadClusterError(
              error: 'Please Logout and Login to account'));
        }
      },
    );

    on<HomeScreenStateChangeEvent>((event, emit) {
      DateTime now=DateTime.now();
      emit(HomeScreenStateChanged(now:now));
    },);

    on<CreateClusterEvent>((event, emit) async{
      String clusterName=event.clusterName;
      bool isUsePas=event.isPassUse;
      String pass=event.pass;
      var userInfo = await SharedPref.getStringList(key: shploginInfo);
        if (userInfo != null && userInfo.isNotEmpty) {
          String userId = userInfo[2];
          var res= await homeScreenRepository.createCluster(clusterName, pass, isUsePas, userId);
          if (res != 'false' && res == 'Cluster Create Successfully') {
            emit(CreateClusterSuccess(message: res));
          } else {
            emit(CreateClusterFail(error: res));
          }
        }else{
          emit(const CreateClusterFail(error: 'backtoLogin'));
        }
    },);

    on<ClusterPasswordValidate>((event, emit) async{
      String clusterIdval=event.clusterIdval;
      String password=event.password;
      int index=event.index;
      var userInfo = await SharedPref.getStringList(key: shploginInfo);
        if (userInfo != null && userInfo.isNotEmpty) {
          String userId = userInfo[2];
          var res= await homeScreenRepository.validateClusterPassword(userId, clusterIdval, password);
          if (res != false) {
            var data=jsonDecode(res);
            if (data['error'] == 0) {
              emit(PasswordCorrect(index: index));
            }else{
              emit(PasswordFail(error: data['data']));
            }
          }else{
            emit(PasswordFail(error: res));
          }
        }else{
          emit(const PasswordFail(error: 'UserId Incorrect'));
        }
    },);

    on<GetCategoriesList>((event, emit) async{
      String clusteridval=event.clusteridval;
      int index=event.index;
      var userInfo = await SharedPref.getStringList(key: shploginInfo);
        if (userInfo != null && userInfo.isNotEmpty) {
          String userId = userInfo[2];
          var res = await homeScreenRepository.getCategoryList(userId, clusteridval);
          if (res != false) {
            var data=jsonDecode(res);
            List<CategoryModel> categoryList =
                (data as List).map((e) => CategoryModel.fromJson(e)).toList();
            emit(LoadCategorySuccess(categoryList: categoryList,index: index));
          }else{
            emit(HomeScreenError(error: res));
          }
        }
    },);
  }
}
