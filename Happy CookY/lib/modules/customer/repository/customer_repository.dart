
import 'package:register_customer/services/api_service.dart';

abstract class CustomerRepository{
  Future<dynamic> fetchCustomers();
}

class CustomerRepositoryImpl extends CustomerRepository{
  ApiService apiService=ApiService();
  @override
  Future fetchCustomers(){
    return apiService.getData('api/Customer');
  }
}