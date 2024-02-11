part of 'category_create_form_state_management_bloc.dart';

sealed class CategoryCreateFormStateManagementEvent extends Equatable {
  const CategoryCreateFormStateManagementEvent();

  @override
  List<Object> get props => [];
}

class CreateCategory extends CategoryCreateFormStateManagementEvent{
  final String categoryName;
  final String clusterIdval;
  final int collectValue;
  final String collectDescription;
  final String ownerIdval;
  final String startDate;
  final String endDate;
  const CreateCategory({required this.categoryName,
  required this.clusterIdval,
  required this.collectValue,
  required this.collectDescription,
  required this.ownerIdval,
  required this.startDate,
  required this.endDate});
}

class FrashMemberList extends CategoryCreateFormStateManagementEvent{
  final String userdata;
  final String clusterIdval;
  const FrashMemberList({required this.userdata,required this.clusterIdval});
}
