
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:register_customer/config/routes/content_ext.dart';
import 'package:register_customer/config/routes/routes.dart';
import 'package:register_customer/modules/sign%20up/bloc/signup_state_management_bloc.dart';
import 'package:register_customer/widgets/common_buttons.dart';
import 'package:register_customer/widgets/common_dialog.dart';
import 'package:register_customer/widgets/common_textfields.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  TextEditingController userName=TextEditingController();
  TextEditingController emailName=TextEditingController();
  TextEditingController passwordcontroller=TextEditingController();
  TextEditingController confirmPass=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: SafeArea(
        child: BlocConsumer<SignupStateManagementBloc, SignupStateManagementState>(
          listener: (context, state) {
            if (state is CreateAccountFail) {
              DialogService.okDialog(
                parentContext: context, 
                okPress: (){
                  Navigator.of(context).pop();
                },
                title: 'register',
                content: state.error
                );
            }
            if (state is CreateAccountSuccess) {
              context.left(Routes.customerpage, (route) => false);
            }
          },
          builder: (context, state) {
            return SafeArea(
              child: SingleChildScrollView(
                reverse: true,
                child: Column(
                  children: [
                    // GestureDetector(
                    //   onTap: (){},
                    //   child: CircleAvatar(
                    //     radius: 50.0,
                    //     // backgroundImage: Image.asset(
                    //     //   'assets/images/user-profile-svgrepo-com.svg',
                    //     // ).image,
                    //     child: Stack(
                    //       children: [
                    //         SvgPicture.asset('assets/images/user-profile-svgrepo-com.svg'),
                    //         Align(
                    //           alignment: Alignment.bottomRight,
                    //           child: CircleAvatar(
                    //             radius: 16,
                    //             backgroundColor: Colors.transparent,
                    //             foregroundColor: Colors.white,
                    //             child: Icon(
                    //               Icons.edit,
                    //               size: 30,
                    //               color: Colors.yellow[70],
                    //             ),
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(height: 100),
                    // Text(tr('Welcome Onboard'),style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    // Text(tr("Let's help you meet up your tasks")),
                    Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child:
                            SvgPicture.asset('assets/images/signup_logo.svg'),
                      ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(25, 50, 25, 10),
                        child: CommonTextFields.userInfoTextField(
                          paramentContext: context,
                            hintText: 'Enter Your Name',
                            labeltext: 'Enter Your Name',
                            controller: userName),
                      ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                        child: CommonTextFields.userInfoTextField(
                          paramentContext: context,
                            hintText: 'Enter Your Email',
                            labeltext: 'Enter Your Email',
                            controller: emailName),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                        child: CommonTextFields.userInfoTextField(
                          paramentContext: context,
                            hintText: 'Enter Password',
                            labeltext: 'Enter Password',
                            controller: passwordcontroller),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                        child: CommonTextFields.userInfoTextField(
                          paramentContext: context,
                            hintText: 'Enter Confirm Password',
                            labeltext: 'Enter Confirm Password',
                            controller: confirmPass),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 50,bottom: 10),
                        child: CommonButtons.customInputButton(
                          bottonName: 'register', 
                          onPress: (){
                            BlocProvider.of<SignupStateManagementBloc>(context)
                            .add( CreateAccount(
                              username: userName.text,
                              email: emailName.text,
                              password: passwordcontroller.text,
                              confirmpassword: confirmPass.text
                            ));
                          }),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(tr('alreadyhaveanaccount'),style: TextStyle(color: Theme.of(context).colorScheme.secondaryContainer),),
                          TextButton(
                              onPressed: () {
                                context.left(Routes.login, (route) => false);
                              },
                              child: Text(tr('login'),style: const TextStyle(color: Colors.blue),))
                        ],
                      )
                  ],
                ),
              ),
            );
          },
        ),
      // appBar: AppBar(
      //   title: const Text('Sign Up'),
      //   automaticallyImplyLeading: false,
      // ),
      // body: Center(
      //   child: Column(
      //     children: [
      //       TextField(
      //         controller: emailName,
      //         decoration: const InputDecoration(
      //           label:  Text('Enter User Email'),
      //           hintText: 'Enter User Email'
      //         ),
      //       ),
      //       const Spacer(),
      //       TextField(
      //         controller: emailName,
      //         decoration: const InputDecoration(
      //           label:  Text('Enter User Name'),
      //           hintText: 'Enter User Name'
      //         ),
      //       ),
      //       const Spacer(),
      //       TextField(
      //         controller: emailName,
      //         decoration: const InputDecoration(
      //           label:  Text('Enter User Password'),
      //           hintText: 'Enter User Password'
      //         ),
      //       ),
            
      //       ElevatedButton(
      //           style: ElevatedButton.styleFrom(
      //             backgroundColor: const Color(0xFF00b6e6),
      //             minimumSize: const Size(330, 51),
      //             shape: RoundedRectangleBorder(
      //               borderRadius: BorderRadius.circular(30.0),
      //             ),
      //           ),
      //           onPressed: () {},
      //           child: const Text('Log In'))
        
      //     ],
      //   ),
      // ),
    ));
  }
}