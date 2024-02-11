part of 'collect_report_state_management_bloc.dart';

sealed class CollectReportStateManagementState extends Equatable {
  const CollectReportStateManagementState();
  
  @override
  List<Object> get props => [];
}

final class CollectReportStateManagementInitial extends CollectReportStateManagementState {}

class CollectReportError extends CollectReportStateManagementState{
  final String error;
  const CollectReportError({required this.error});
}

class CollectReportSuccess extends CollectReportStateManagementState{
  final int total;
  final int possessValue;
  const CollectReportSuccess({required this.total,required this.possessValue});
  
  @override
  List<Object> get props => [total,possessValue];
}

class LoadedCollectReport extends CollectReportStateManagementState{
  final List<CollectDatas> collectDatas;
  const LoadedCollectReport({required this.collectDatas});
  
  @override
  List<Object> get props => [collectDatas];
}


class FrashUserListSuccess extends CollectReportStateManagementState{
  final List<UserData> userDatas;
  const FrashUserListSuccess({required this.userDatas});
  
  @override
  List<Object> get props => [userDatas];
}

