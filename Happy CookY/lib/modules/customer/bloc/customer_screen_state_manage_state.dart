part of 'customer_screen_state_manage_bloc.dart';

abstract class CustomerScreenStateManageState extends Equatable{
  const CustomerScreenStateManageState();
  @override
  List<Object?> get props => [];
}

final class CustomerScreenStateManageInitial extends CustomerScreenStateManageState {}

class FetchCustomerSuccess extends CustomerScreenStateManageState{
  final List<Customer> cusList;
  const FetchCustomerSuccess({required this.cusList});
  @override
  List<Object?> get props => [cusList];
}


class FetchCustomersFail extends CustomerScreenStateManageState{}