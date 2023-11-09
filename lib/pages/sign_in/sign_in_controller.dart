import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:yt_ulearning/common/apis/user_api.dart';
import 'package:yt_ulearning/common/entities/user.dart';
import 'package:yt_ulearning/common/values/constant.dart';
import 'package:yt_ulearning/common/widgets/flutter_toast.dart';
import 'package:yt_ulearning/global.dart';
import 'package:yt_ulearning/pages/home/home_controller.dart';
import 'package:yt_ulearning/pages/sign_in/bloc/signin_blocs.dart';

class SignInController {
  final BuildContext context;

  SignInController({required this.context});
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> handleSignIn(String type) async {
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
            String? displayName = user.displayName;
            String? email = user.email;
            String? id = user.uid;
            String? photoURL = user.photoURL;

            //TASK -> convert to object and convert to json
            // Wrap and create an object
            LoginRequestEntity loginRequestEntity = LoginRequestEntity();
            loginRequestEntity.avatar = photoURL;
            loginRequestEntity.name = displayName;
            loginRequestEntity.email = email;
            loginRequestEntity.open_id = id;
            //type 1 -> means email login
            loginRequestEntity.type = 1;

            //We got verified user from firebase
            toastInfo(msg: "user exists");
            await asyncPostAllData(loginRequestEntity);
            if (context.mounted) {
              await HomeController(context: context).init();
            }
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
      } else if (type == "google") {
        try {
          // Trigger the authentication flow
          final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

          if (googleUser == null) {
            // Handle the case where the user cancels the sign-in process.
            return;
          }

          // Obtain the auth details from the request
          final GoogleSignInAuthentication googleAuth =
              await googleUser.authentication;

          // Create a new credential
          final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          );

          // Sign in to Firebase with the Google credentials
          final UserCredential userCredential =
              await FirebaseAuth.instance.signInWithCredential(credential);

          String? displayName = userCredential.user?.displayName;
          String? email = userCredential.user?.email;
          String? id = userCredential.user?.uid;
          String? photoURL =
              userCredential.user?.photoURL ?? "uploads/default.png";

          //TASK -> convert to object and convert to json
          // Wrap and create an object
          LoginRequestEntity loginRequestEntity = LoginRequestEntity();
          loginRequestEntity.avatar = photoURL;
          loginRequestEntity.name = displayName;
          loginRequestEntity.email = email;
          loginRequestEntity.open_id = id;
          //type 1 -> means email login
          loginRequestEntity.type = 2;

          await asyncPostAllData(loginRequestEntity);
          if (context.mounted) {
            await HomeController(context: context).init();
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

  //passing data to the server
  Future<void> asyncPostAllData(LoginRequestEntity loginRequestEntity) async {
    EasyLoading.show(
      indicator: const CircularProgressIndicator(),
      maskType: EasyLoadingMaskType.clear,
      dismissOnTap: true,
    );
    var result = await UserAPI.login(params: loginRequestEntity);
    if (result.code == 200) {
      try {
        Global.storageService.setString(
            AppConstants.STORAGE_USER_PROFILE_KEY, jsonEncode(result.data!));
        //used for authorization
        Global.storageService.setString(
            AppConstants.STORAGE_USER_TOKEN_KEY, result.data!.access_token!);
        EasyLoading.dismiss();
        if (context.mounted) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil("/application", (route) => false);
        }
      } catch (e) {
        print("Saving local storage error ${e.toString()}");
      }
    } else {
      EasyLoading.dismiss();
      toastInfo(msg: "Login failed");
    }
  }
}
