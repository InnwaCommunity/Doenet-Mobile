part of 'category_create_form_state_management_bloc.dart';

sealed class CategoryCreateFormStateManagementState extends Equatable {
  const CategoryCreateFormStateManagementState();
  
  @override
  List<Object> get props => [];
}

final class CategoryCreateFormStateManagementInitial extends CategoryCreateFormStateManagementState {}
