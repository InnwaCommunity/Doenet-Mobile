
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:register_customer/model/customer_data_model.dart';
import 'package:register_customer/modules/customer/repository/customer_repository.dart';

part 'customer_screen_state_manage_event.dart';
part 'customer_screen_state_manage_state.dart';

class CustomerScreenStateManageBloc extends Bloc<CustomerScreenStateManageEvent, CustomerScreenStateManageState> {
  final CustomerRepository customerRepository;
  CustomerScreenStateManageBloc(this.customerRepository) : super(CustomerScreenStateManageInitial()) {
    on<CustomerScreenStateManageEvent>((event, emit) {});
    on<FetchCustomers>((event, emit) async{
      emit(CustomerScreenStateManageInitial());
      var res= await customerRepository.fetchCustomers();
      if (res != false) {
        var jsonList = jsonDecode(res) as List<dynamic>;
        List<Customer> cusList= jsonList.map((json) => Customer.fromJson(json)).toList();
        emit(FetchCustomerSuccess(cusList: cusList));
      } else {
        emit(FetchCustomersFail());
      }
    },);
  }
}
