import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class DialogService{
  static void okDialog(
      {required BuildContext parentContext,
      required void Function() okPress,
      void Function()? cancelPress,
      String? title,
      String? content}) {
        showDialog(context: parentContext, builder: (context){
          return AlertDialog(
            surfaceTintColor: Colors.transparent,
            title: title!= null ? Text(tr(title)) : Container(),
            content: content != null ? Text(tr(content) ) : Container(),
            actions: [
              cancelPress != null
                  ? TextButton(
                      onPressed: cancelPress, child: Text(tr('Cancel')))
                  : Container(),
              TextButton(onPressed: okPress, child: Text(tr('OK')))
            ],
          );
        });
      }

  static void actionDialog(){}
}