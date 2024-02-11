import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:register_customer/config/routes/content_ext.dart';
import 'package:register_customer/config/routes/routes.dart';
import 'package:register_customer/modules/sign%20in/bloc/login_bloc.dart';
import 'package:register_customer/modules/sign%20in/bloc/login_event.dart';
import 'package:register_customer/modules/sign%20in/bloc/login_state.dart';
import 'package:register_customer/widgets/common_buttons.dart';
import 'package:register_customer/widgets/common_dialog.dart';
import 'package:register_customer/widgets/common_textfields.dart';


class LoginPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController=TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Theme.of(context).colorScheme.secondary,
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      // ),
      body: SafeArea(
        child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is SuccessLoginState) {
            context.left(Routes.home, (route) => false);
          }else if(state is FailureLoginState){
            DialogService.okDialog(
                    parentContext: context,
                    okPress: () {
                      Navigator.of(context).pop();
                    },
                    title: 'login',
                    content: 'Invalidusernamepassword');
          }else if(state is NeedToAddUserName){
            DialogService.okDialog(
                    parentContext: context,
                    okPress: () {
                      Navigator.of(context).pop();
                    },
                    title: 'login',
                    content: 'NeedToAddUserName');
          }else if(state is NeedToAddPassword){
            DialogService.okDialog(
                    parentContext: context,
                    okPress: () {
                      Navigator.of(context).pop();
                    },
                    title: 'login',
                    content: 'NeedToAddPassword');
          }
        },
        child: Stack(
          children: [
            SingleChildScrollView(
              reverse: true,
              child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: SvgPicture.asset('assets/images/sign_in_logo.svg'),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(25, 50, 25, 10),
                        child: CommonTextFields.userInfoTextField(
                          paramentContext: context,
                            hintText: 'Enter Your Name',
                            labeltext: 'Enter Your Name',
                            controller: usernameController),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(25, 10, 25, 25),
                        child: CommonTextFields.userInfoTextField(
                          paramentContext: context,
                            hintText: 'Enter Your Email',
                            labeltext: 'Enter Your Email',
                            controller: emailController),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(25, 10, 25, 25),
                        child: CommonTextFields.userInfoTextField(
                          paramentContext: context,
                            hintText: 'Enter Your Password',
                            labeltext: 'Enter Your Password',
                            controller: passwordController),
                      ),
                      TextButton(
                        onPressed: (){}, 
                        child: Text(tr('forget password'),
                        style: const TextStyle(color: Colors.blueAccent),)),
                      
                      Padding(
                        padding: const EdgeInsets.only(top: 25,bottom: 25),
                        child: CommonButtons.customInputButton(
                            bottonName: 'login',
                            onPress: () {
                              BlocProvider.of<LoginBloc>(context).add(
                                PerformLoginEvent(
                                  username: usernameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                ),
                              );
                            }),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(tr('donothaveaaccount'),style:TextStyle(color: Theme.of(context).colorScheme.secondaryContainer)),
                          TextButton(
                            onPressed: (){
                              context.toName(Routes.signup);
                            }, 
                            child: Text(tr('signup'),style:const TextStyle(color: Colors.blue)))
                        ],
                      )
                      
                    ],
                  ),
            )
          ],
        ),
        // child: Center(
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: <Widget>[
        //       TextField(
        //         controller: usernameController,
        //         decoration: const InputDecoration(
        //           hintText: 'Username',
        //         ),
        //       ),
        //       TextField(
        //         controller: passwordController,
        //         // obscureText: true,
        //         decoration: const InputDecoration(
        //           hintText: 'Password',
        //         ),
        //       ),
        //       const SizedBox(height: 20),
        //       ElevatedButton(
        //         onPressed: () {
        //           BlocProvider.of<LoginBloc>(context).add(
        //             PerformLoginEvent(
        //               username: usernameController.text,
        //               password: passwordController.text,
        //             ),
        //           );
        //         },
        //         child: const Text('Login'),
        //       ),
        //       const SizedBox(height: 20),
        //       TextButton(onPressed: (){
        //         context.toName(Routes.signup);
        //       }, child: const Text('Sign Up'))
        //     ],
        //   ),
        // ),
      ),)
    );
  }
}

class LoginTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  const LoginTextField(
      {Key? key, required this.hintText, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(hintText: hintText),
      ),
    );
  }
}
