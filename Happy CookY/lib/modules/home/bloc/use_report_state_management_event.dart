part of 'use_report_state_management_bloc.dart';

sealed class UseReportStateManagementEvent extends Equatable {
  const UseReportStateManagementEvent();

  @override
  List<Object> get props => [];
}

class LoadUseReportList extends UseReportStateManagementEvent {
  final String categoryIdval;
  const LoadUseReportList({required this.categoryIdval});
}

class SaveUseReportEvent extends UseReportStateManagementEvent{
  final String useAmount;
  final String description;
  final String categoryid;
  const SaveUseReportEvent({required this.useAmount,required this.description,required this.categoryid});
}

class FrashUserList extends UseReportStateManagementEvent{
  final String userdata;
  final String categoryIdval;
  const FrashUserList({required this.userdata,required this.categoryIdval});
}
