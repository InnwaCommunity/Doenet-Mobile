part of 'home_screen_state_management_bloc.dart';

abstract class HomeScreenStateManagementState extends Equatable{
  const HomeScreenStateManagementState();
  @override
  List<Object?> get props => [];
}

final class HomeScreenStateManagementInitial extends HomeScreenStateManagementState {}

class LoadClusterSuccess extends HomeScreenStateManagementState{
  final List<ClusterModel> clusterList;
  const LoadClusterSuccess({required this.clusterList});
}

class LoadClusterError extends HomeScreenStateManagementState{
  final String error;
  const LoadClusterError({required this.error});
  @override
  List<Object?> get props => [error];
}


class HomeScreenStateChanged extends HomeScreenStateManagementState{
  final DateTime now;
  const HomeScreenStateChanged({required this.now});
  @override
  List<Object?> get props => [now];
}

class CreateClusterSuccess extends HomeScreenStateManagementState{
  final String message;
  const CreateClusterSuccess({required this.message});
}

class CreateClusterFail extends HomeScreenStateManagementState{
  final String error;
  const CreateClusterFail({required this.error});
}


class PasswordCorrect extends HomeScreenStateManagementState{
  final int index;
  const PasswordCorrect({required this.index});
  @override
  List<Object?> get props => [index];
}

class PasswordFail extends HomeScreenStateManagementState{
  final String error;
  const PasswordFail({required this.error});
}

class LoadCategorySuccess extends HomeScreenStateManagementState{
  final List<CategoryModel> categoryList;
  final int index;
  const LoadCategorySuccess({required this.categoryList,required this.index});
}

class HomeScreenError extends HomeScreenStateManagementState{
  final String error;
  const HomeScreenError({required this.error});
}