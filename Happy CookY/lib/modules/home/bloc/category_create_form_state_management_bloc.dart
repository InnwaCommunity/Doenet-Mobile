import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'category_create_form_state_management_event.dart';
part 'category_create_form_state_management_state.dart';

class CategoryCreateFormStateManagementBloc extends Bloc<CategoryCreateFormStateManagementEvent, CategoryCreateFormStateManagementState> {
  CategoryCreateFormStateManagementBloc() : super(CategoryCreateFormStateManagementInitial()) {
    on<CategoryCreateFormStateManagementEvent>((event, emit) {});
  }
}
