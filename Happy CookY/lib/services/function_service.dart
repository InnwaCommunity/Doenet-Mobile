import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:register_customer/config/Sharef/share_pref.dart';
import 'package:register_customer/constants/constants.dart';

Future<ThemeMode> getThemeMode() async{
  bool? theme=await SharedPref.getBool(key: shpthemeMode);
  if (theme != null) {
    return theme ? ThemeMode.dark : ThemeMode.light;
  } else {
    return ThemeMode.system;
  }
}


Route? makeRoute(Widget widget,RouteSettings settings){
    return MaterialPageRoute(
      builder: (context){
        return widget;
      },settings: settings);
  }



  Future<String> getToken() async {
    String token= await SharedPref.getString(key: shpaccessToken) ?? '';
    log(token);
    return token;
  }

  
class HexColor extends Color {
  HexColor(String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return int.parse(hexColor, radix: 16);
  }
}

bool validateEmail({required String email}) {
  return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9-]+\.[a-zA-Z]+")
      .hasMatch(email);
}

bool passwordValidationUpperCase(String? value) {
  String pattern = r'[A-Z]';
  RegExp regExp = RegExp(pattern);
  return regExp.hasMatch(value!);
}

bool passwordValidationLowerCase(String? value) {
  String pattern = r'[a-z]';
  RegExp regExp = RegExp(pattern);
  return regExp.hasMatch(value!);
}

bool passwordValidationNumeric(String? value) {
  String pattern = r'[0-9]';
  RegExp regExp = RegExp(pattern);
  return regExp.hasMatch(value!);
}

bool passwordValidationSpecialCharacter(String? value) {
  String pattern = r'[!@#$%^&*(),.?":{}|<>]';
  RegExp regExp = RegExp(pattern);
  return regExp.hasMatch(value!);
}

