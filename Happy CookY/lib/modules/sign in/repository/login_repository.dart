import 'package:register_customer/services/api_service.dart';



abstract class LoginRepository{
  Future<dynamic> login(String username,String email,String password);
}

class LoginRepositoryImpl extends LoginRepository{
  ApiService apiService=ApiService();

  @override
  Future login(String username,String email, String password) async{
    Map<String, String> requestHeaders = {'Content-type': 'application/json'};
    Map<String,dynamic> requestBody ={
        'LoginType': '1',
        'username': username,
        'password': password,
        'email': email
    };
    return apiService.postLogin('api/token', requestHeaders, requestBody);
  }
}