import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yt_ulearning/common/values/constant.dart';
import 'package:yt_ulearning/common/widgets/flutter_toast.dart';
import 'package:yt_ulearning/pages/register/bloc/register_blocs.dart';

class RegisterController {
  final BuildContext context;
  const RegisterController({required this.context});

  void handleEmailRegister() async {
    final state = context.read<RegisterBlocs>().state;
    String userName = state.userName;
    String email = state.email;
    String password = state.password;
    String rePassword = state.rePassword;

    if (userName.isEmpty) {
      toastInfo(msg: 'User name can not be empty');
    }
    if (email.isEmpty) {
      toastInfo(msg: 'Email can not be empty');
    }
    if (password.isEmpty) {
      toastInfo(msg: 'Password can not be empty');
    }
    if (rePassword.isEmpty) {
      toastInfo(msg: 'Password confirmation is wrong');
    }

    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      if (credential.user != null) {
        await credential.user?.sendEmailVerification();
        await credential.user?.updateDisplayName(userName);
        String photoUrl = "${AppConstants.SERVER_API_URL}uploads/default.png";
        await credential.user?.updatePhotoURL(photoUrl);

        toastInfo(msg: "Please check your email to verify your account");
        Navigator.of(context).pop();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        toastInfo(msg: "The password provided is too Weak");
      } else if (e.code == 'email-already-in-use') {
        toastInfo(msg: "The account already exists for that email");
      } else if (e.code == 'invalid-email') {
        toastInfo(msg: "The email address is not valid");
      }
    }
  }
}
