

import 'package:register_customer/services/api_service.dart';

abstract class AutoLoginRepository{
  Future<dynamic> checkUserInfo(String username,String password);
}

class AutoLoginRepositoryImpl extends AutoLoginRepository{
  ApiService apiService=ApiService();

  @override
  Future checkUserInfo(String username,String password) async{
    Map<String, String> requestHeaders = {'Content-type': 'application/json'};
    Map<String,dynamic> requestBody ={
        'LoginType': '1',
        'username': username,
        'password': password,
    };
    return apiService.postLogin('api/token', requestHeaders, requestBody);
  }
}