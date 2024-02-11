import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:register_customer/config/routes/content_ext.dart';
import 'package:register_customer/config/routes/routes.dart';
import 'package:register_customer/modules/splash_screen/bloc/splash_state_management_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkAutoLogin();
  }

  void checkAutoLogin(){
    BlocProvider.of<SplashStateManagementBloc>(context).add( CheckAutoLogin());
  }

  @override
  Widget build(BuildContext context) {
    return  BlocListener<SplashStateManagementBloc, SplashStateManagementState>(
      listener: (context, state) {
        if (state is AutoLoginSuccess) {
          context.left(Routes.home, (route) => false);
        }
        if (state is AutoLoginFail) {
          context.left(Routes.login, (route) => false);
        }
      },
      child: Scaffold(
          body: Center(
            child: AnimatedContainer(
              duration: const Duration(seconds: 1),
              child: const Text(
                'Happy Cooky',
                style: TextStyle(color: Colors.green, fontSize: 25),
              ),
            ),
          ),
        )
    );
  }
}
