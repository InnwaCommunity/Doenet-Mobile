part of 'customer_screen_state_manage_bloc.dart';

abstract class CustomerScreenStateManageEvent extends Equatable{
  const CustomerScreenStateManageEvent();
  @override
  List<Object?> get props => [];
}

class FetchCustomers extends CustomerScreenStateManageEvent{}
