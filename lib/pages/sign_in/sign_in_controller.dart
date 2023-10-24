import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yt_ulearning/common/widgets/flutter_toast.dart';
import 'package:yt_ulearning/pages/sign_in/bloc/signin_blocs.dart';

class SignInController {
  final BuildContext context;

  const SignInController({required this.context});

  void handleSignIn(String type) async {
    try {
      if (type == "email") {
        //BlocProvider.of<SignInBloc>(context).state
        final state = context.read<SignInBlocs>().state;
        String emailAddress = state.email;
        String password = state.password;
        if (emailAddress.isEmpty) {
          toastInfo(msg: "email is empty");
        } else {
          print("email is $emailAddress");
          toastInfo(msg: "email is $emailAddress");
        }
        if (password.isEmpty) {
          toastInfo(msg: "password is empty");
        }
        try {
          final credential =
              await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailAddress,
            password: password,
          );
          if (credential.user == null) {
            toastInfo(msg: "user does not exists");
          }
          if (!credential.user!.emailVerified) {
            toastInfo(msg: 'message not verified');
          }

          var user = credential.user;
          if (user != null) {
            //We got verified user from firebase
            toastInfo(msg: "user exists");
          } else {
            //We have error getting user from firebase
            print("no user");
            toastInfo(msg: "no user");
          }
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            print('No user found for that email');
            toastInfo(msg: "No user found for that email");
          } else if (e.code == 'wrong-password') {
            print('Wrong password provided for that user');
            toastInfo(msg: "Wrong password provided for that user");
          } else if (e.code == 'invalid-email') {
            print("your email format is wrong");
            toastInfo(msg: "your email format is wrong");
          }
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
