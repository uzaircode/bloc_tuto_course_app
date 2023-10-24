import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yt_ulearning/pages/register/bloc/register_blocs.dart';
import 'package:yt_ulearning/pages/sign_in/bloc/signin_blocs.dart';
import 'package:yt_ulearning/pages/welcome/bloc/welcome_blocs.dart';

class AppBlocProviders {
  static get allBlocProviders => [
        BlocProvider(lazy: false, create: (context) => WelcomeBloc()),
        BlocProvider(create: (context) => SignInBlocs()),
        BlocProvider(create: (context) => RegisterBlocs()),
      ];
}
