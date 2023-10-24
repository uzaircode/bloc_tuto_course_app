import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yt_ulearning/pages/sign_in/bloc/signin_blocs.dart';
import 'package:yt_ulearning/pages/sign_in/bloc/signin_events.dart';
import 'package:yt_ulearning/pages/sign_in/bloc/signin_states.dart';
import 'package:yt_ulearning/pages/sign_in/sign_in_controller.dart';
import '../../common/widgets/common_widgets.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBlocs, SignInState>(
      builder: (context, state) {
        return Container(
          color: Colors.white,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: buildappBar('Login'),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildThirdPartyLogin(context),
                    Center(
                      child:
                          reuseableText('Or use your email account to login'),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 66.h),
                      padding: EdgeInsets.only(left: 25.w, right: 25.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          reuseableText('Email'),
                          SizedBox(height: 5.h),
                          buildTextField(
                              'Enter your email address', 'email', 'user',
                              (value) {
                            context.read<SignInBlocs>().add(
                                  EmailEvent(value),
                                );
                          }),
                          SizedBox(height: 5.h),
                          reuseableText('Password'),
                          buildTextField(
                              'Enter your password', 'password', 'lock',
                              (value) {
                            context.read<SignInBlocs>().add(
                                  PasswordEvent(value),
                                );
                          }),
                        ],
                      ),
                    ),
                    forgotPassword(),
                    SizedBox(height: 70.h),
                    buildLogInAndRegButton('Log In', "login", () {
                      SignInController(context: context).handleSignIn("email");
                      // Navigator.of(context).pushNamedAndRemoveUntil(, (route) => false);
                    }),
                    buildLogInAndRegButton('Sign Up', "register", () {
                      Navigator.of(context).pushNamed('/register');
                    }),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
