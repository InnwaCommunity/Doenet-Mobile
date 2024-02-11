import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:register_customer/config/routes/routes.dart';
import 'package:register_customer/config/themes/cubit/theme_cubit.dart';
import 'package:register_customer/constants/constants.dart';
import 'package:register_customer/services/function_service.dart';
import 'package:register_customer/services/theme_service.dart';
import 'dart:io';


class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  HttpOverrides.global =  MyHttpOverrides();
  ThemeMode themeMode= await getThemeMode();
  runApp(
    EasyLocalization(
      supportedLocales:const [Locale('en', 'US'), Locale('my', 'MM')],
      path: 'languages',
      fallbackLocale: const Locale('en', 'US'),
      child: BlocProvider<ThemeCubit>(
        create: (context)=> ThemeCubit(themeMode),
        lazy: false,
        child: const MyApp()),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit,ThemeMode>(
      builder: (context,themeMode){
        return MaterialApp(
          localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              themeMode: themeMode,
              theme: lightTheme,
              darkTheme: darkTheme,
              debugShowCheckedModeBanner: false,
              title: 'Chookey',
              navigatorKey: navigatorKey,
              onGenerateRoute: Routes.routeGenerator,
        );
      }
      );
  }
}
