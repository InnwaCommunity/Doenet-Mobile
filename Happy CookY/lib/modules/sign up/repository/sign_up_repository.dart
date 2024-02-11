
import 'package:register_customer/services/api_service.dart';

abstract class SignUpRepository{
  Future<dynamic> signup({required String username,
  required String email,required String password});
}

class SignUpRepositoryImpl extends SignUpRepository {
  @override
  Future signup(
      {required String username,
      required String email,
      required String password}) async {
    ApiService apiService = ApiService();

    Map<String, dynamic> requestBody = {
      "AdminName": username,
      "LoginName": username,
      "AdminEmail": email,
      "Password": password,
      "AdminPhoto": ""
    };
    return await apiService.postSignup(
        'api/Admin', requestBody);
  }
}
