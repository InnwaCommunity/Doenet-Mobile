import 'dart:convert';
import 'dart:developer';
import 'package:register_customer/config/Sharef/share_pref.dart';
import 'package:register_customer/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:register_customer/model/login_data_model.dart';
import 'package:register_customer/services/function_service.dart';

class ApiService{
  String accessToken='';

  Future<dynamic> postLogin(
    String apiUrl,
    Map<String,String> requestHeaders,
    Map<String,dynamic> requestBody
  ) async{
    try {
      Uri uri= getUri(apiUrl);
    var response= await http.post(uri,body: jsonEncode(requestBody),headers: requestHeaders);
    if (response.statusCode == 200) {
      LoginDataModel loginDataModel =
            LoginDataModel.fromJson(jsonDecode(response.body));
        accessToken = loginDataModel.accessToken ?? '';
      await SharedPref.setString(key: shpaccessToken, value: accessToken);
    
      await SharedPref.setStringList(key: shploginInfo, value:[requestBody['username'],requestBody['email'],loginDataModel.userId ?? '', requestBody['password']] );
      return 'trueuser';
    }else if(response.statusCode == 400){
      // return response.body;
      return 'false';
    }
    return 'false';
    }on Exception catch (_) {
      return 'false';
    }
  }

  Future<dynamic> postSignup(String apiUrl, 
      Map<String, dynamic> requestBody) async {
      Map<String, String> requestHeaders = {'Content-type': 'application/json'};
    try {
      Uri uri = getUri(apiUrl);
      var response = await http.post(uri,
          body: jsonEncode(requestBody), headers: requestHeaders);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return 'false';
      }
    } on Exception catch (_) {
      return 'false';
    }
  }

  Future<dynamic> post(String apiUrl, 
      Map<String, dynamic> requestBody) async {
      Map<String, String> requestHeaders = {
        'Authorization': 'Bearer ${await getToken()}'
      };
      requestHeaders.putIfAbsent('Content-type', () => 'application/json');
    try {
      Uri uri = getUri(apiUrl);
      var response = await http.post(uri,
          body: jsonEncode(requestBody), headers: requestHeaders);
      if (response.statusCode == 200) {
        log(response.body);
        return response.body;
      } else {
        return 'false';
      }
    } on Exception catch (_) {
      return 'false';
    }
  }

  Future<dynamic> getData(String apiUrl)async{
    Map<String, String> requestHeaders = {
        'Authorization': 'Bearer ${await getToken()}'
      };

    Uri url = getUri(apiUrl);
      var response = await http.get(url, headers: requestHeaders);
      if (response.statusCode == 200) {
        // final jsonList = jsonDecode(response.body) as List<dynamic>;
        return response.body;
      } else if (response.statusCode == 401) {
        return 'false';
      }
      return 'false';
  }

  Uri getUri(String apiUrl){
    log(defaultBaseUrl + apiUrl);
    return Uri.parse(defaultBaseUrl + apiUrl);
  }
}















// import 'dart:async';
// import 'dart:developer';
// import 'package:flutter/foundation.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:register_customer/model/login_data_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ApiService {
//   String accessToken = '';

//   Future<LoginDataModel> postAuthData(
//       String apiUrl,
//       Map<String, String> requestHeaders,
//       Map<String, dynamic> requestBody) async {
//     try {
//       Uri url = Uri.parse(apiUrl);
//       log(url.toString());
//       Map<String, String> requestHeaders = {'Content-type': 'application/json'};

//       var response = await http.post(url,
//           body: jsonEncode(requestBody), headers: requestHeaders);
//           log(response.statusCode.toString());
//       if (response.statusCode == 200) {
//         LoginDataModel loginDataModel =
//             LoginDataModel.fromJson(jsonDecode(response.body));
//         accessToken = loginDataModel.accessToken ?? '';
//         log('token is $accessToken');
//         final prefs = await SharedPreferences.getInstance();
//         prefs.setString('accessToken', accessToken);
//         return loginDataModel;
//       } else if (response.statusCode == 400) {
//         return LoginDataModel.fromJson(jsonDecode(response.body));
//       }
//     } catch (e) {
//       if (kDebugMode) {
//         print(e.toString());
//       }
//     }
//     return LoginDataModel(
//       accessToken: null,
//       expiresIn: null,
//       userId: null,
//       loginType: null,
//       userLevelId: null,
//       displayName: null,
//     );
//   }
// }

// class SignInException implements Exception {
//   final String message;
//   SignInException(this.message);
//   @override
//   String toString() => 'SignInException: $message';
// }
