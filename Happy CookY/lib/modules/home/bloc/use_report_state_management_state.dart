part of 'use_report_state_management_bloc.dart';

sealed class UseReportStateManagementState extends Equatable {
  const UseReportStateManagementState();
  
  @override
  List<Object> get props => [];
}

final class UseReportStateManagementInitial extends UseReportStateManagementState {}

class LoadUseReportSuccess extends UseReportStateManagementState {
  final List<UseReportDetailModel> useReportList;
  const LoadUseReportSuccess({required this.useReportList});
  
  @override
  List<Object> get props => [useReportList];
}

class UseReportBlocError extends UseReportStateManagementState{
  final String error;
  const UseReportBlocError({required this.error});
}

class SaveUseReportSuccess extends UseReportStateManagementState{
  final String message;
  const SaveUseReportSuccess({required this.message});
}

class FrashUserListSuccess extends UseReportStateManagementState{
  final List<UserData> userDatas;
  const FrashUserListSuccess({required this.userDatas});
  
  @override
  List<Object> get props => [userDatas];
}
