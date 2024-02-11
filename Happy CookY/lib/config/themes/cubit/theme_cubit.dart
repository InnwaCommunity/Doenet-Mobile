import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:register_customer/config/Sharef/share_pref.dart';
import 'package:register_customer/constants/constants.dart';


class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit(ThemeMode themeMode) : super(themeMode);

  void toggleTheme(){
    if (state == ThemeMode.light) {
      emit(ThemeMode.dark);
      SharedPref.setBool(key: shpthemeMode, value: true);
    } else {
      emit(ThemeMode.light);
      SharedPref.setBool(key: shpthemeMode, value: false);
    }
  }
}
