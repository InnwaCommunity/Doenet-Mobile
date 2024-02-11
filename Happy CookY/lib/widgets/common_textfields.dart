import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CommonTextFields {
  static Widget userInfoTextField(
      {required BuildContext paramentContext,
        required String hintText,
      required String labeltext,
      required TextEditingController controller}) {
    return TextFormField(
      controller: controller,
      style: TextStyle(color: Theme.of(paramentContext).colorScheme.secondaryContainer),
      decoration: InputDecoration(
        focusColor: Colors.blueGrey,
        fillColor: Colors.blueGrey,
        hoverColor: Colors.blueGrey,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue),
          borderRadius: BorderRadius.circular(30)
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue),
          borderRadius: BorderRadius.circular(30)
        ),
        label: Text(tr(labeltext)),
        labelStyle: TextStyle(color: Theme.of(paramentContext).colorScheme.secondaryContainer),
        hintText: tr(hintText),
        hintStyle: TextStyle(color: Theme.of(paramentContext).colorScheme.secondaryContainer),
      ),
    );
  }
}
