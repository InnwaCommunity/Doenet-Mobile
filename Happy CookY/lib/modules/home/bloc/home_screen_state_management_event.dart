part of 'home_screen_state_management_bloc.dart';

abstract class HomeScreenStateManagementEvent extends Equatable{
  const HomeScreenStateManagementEvent();
  @override
  List<Object?> get props => [];
}

class LoadClusterLists extends HomeScreenStateManagementEvent{}

class HomeScreenStateChangeEvent extends HomeScreenStateManagementEvent{}

class CreateClusterEvent extends HomeScreenStateManagementEvent{
  final String clusterName;
  final bool isPassUse;
  final String pass;
  const CreateClusterEvent({required this.clusterName,required this.isPassUse,required this.pass});
}

class ClusterPasswordValidate extends HomeScreenStateManagementEvent{
  final String password;
  final String clusterIdval;
  final int index;
  const ClusterPasswordValidate({required this.password,required this.clusterIdval,required this.index});
}

class GetCategoriesList extends HomeScreenStateChangeEvent{
  final String clusteridval;
  final int index;
  GetCategoriesList({required this.clusteridval,required this.index});
}
