part of 'collect_report_state_management_bloc.dart';

sealed class CollectReportStateManagementEvent extends Equatable {
  const CollectReportStateManagementEvent();

  @override
  List<Object> get props => [];
}

class GetPossessValue extends CollectReportStateManagementEvent{
  final String categoryIdval;
  const GetPossessValue({required this.categoryIdval});
}

class GetCollectReportList extends CollectReportStateManagementEvent{
  final String categoryIdval;
  const GetCollectReportList({required this.categoryIdval});
}

class FrashUserList extends CollectReportStateManagementEvent{
  final String userdata;
  final String categoryIdval;
  const FrashUserList({required this.userdata,required this.categoryIdval});
}

class SaveCollectReport extends CollectReportStateManagementEvent{
  final int collectval;
  final String description;
  const SaveCollectReport({required this.collectval,required this.description});
}