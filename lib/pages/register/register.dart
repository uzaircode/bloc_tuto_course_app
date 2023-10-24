import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yt_ulearning/common/widgets/common_widgets.dart';
import 'package:yt_ulearning/pages/register/bloc/register_blocs.dart';
import 'package:yt_ulearning/pages/register/bloc/register_events.dart';
import 'package:yt_ulearning/pages/register/bloc/register_states.dart';
import 'package:yt_ulearning/pages/register/register_controller.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBlocs, RegisterStates>(
      builder: (context, state) {
        return Container(
          color: Colors.white,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: buildappBar('Sign up'),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    Center(
                      child: reuseableText(
                          'Enter your details below & free sign up'),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 36.h),
                      padding: EdgeInsets.only(left: 25.w, right: 25.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          reuseableText('User name'),
                          buildTextField('Enter your user name', 'name', 'user',
                              (value) {
                            context
                                .read<RegisterBlocs>()
                                .add(UserNameEvent(value));
                          }),
                          reuseableText('Email'),
                          buildTextField(
                              'Enter your email address', 'email', 'user',
                              (value) {
                            context
                                .read<RegisterBlocs>()
                                .add(EmailEvent(value));
                          }),
                          reuseableText('Password'),
                          buildTextField(
                              'Enter your password', 'password', 'lock',
                              (value) {
                            context
                                .read<RegisterBlocs>()
                                .add(PasswordEvent(value));
                          }),
                          reuseableText('Confirm Password'),
                          buildTextField(
                            'Confirm your password',
                            'password',
                            'lock',
                            (value) {
                              context
                                  .read<RegisterBlocs>()
                                  .add(RePasswordEvent(value));
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 25.w),
                      child: reuseableText(
                          'Bys creating an account you have to agree with our Terms & Conditions.'),
                    ),
                    buildLogInAndRegButton('Sign up', "login", () {
                      RegisterController(context: context)
                          .handleEmailRegister();
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
