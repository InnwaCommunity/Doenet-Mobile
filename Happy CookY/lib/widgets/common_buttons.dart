import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:register_customer/services/function_service.dart';

class CommonButtons{
  static Widget customInputButton({required String bottonName,required void Function() onPress}){
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: HexColor('#50C2C9'),
        minimumSize: const Size(325, 62),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero
        )
      ),
      onPressed: onPress, 
      child: Text(tr(bottonName),style: TextStyle(color: HexColor('#FFFFFF'))));
  }
}