import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yt_ulearning/common/routes/names.dart';
import 'package:yt_ulearning/pages/register/bloc/register_blocs.dart';
import 'package:yt_ulearning/pages/register/register.dart';
import 'package:yt_ulearning/pages/sign_in/bloc/signin_blocs.dart';
import 'package:yt_ulearning/pages/sign_in/sign_in.dart';
import 'package:yt_ulearning/pages/welcome/bloc/welcome_blocs.dart';
import 'package:yt_ulearning/pages/welcome/welcome.dart';

class AppPages {
  static List<PageEntity> routes() {
    return [
      PageEntity(
        route: AppRoutes.INITIAL,
        page: const WelcomeScreen(),
        bloc: BlocProvider(create: (_) => WelcomeBloc()),
      ),
      PageEntity(
        route: AppRoutes.SIGN_IN,
        page: const SignInScreen(),
        bloc: BlocProvider(
          create: (_) => SignInBlocs(),
        ),
      ),
      PageEntity(
        route: AppRoutes.REGISTER,
        page: const RegisterScreen(),
        bloc: BlocProvider(
          create: (_) => RegisterBlocs(),
        ),
      ),
      PageEntity(
        route: AppRoutes.APPLICATION,
        page: const WelcomeScreen(),
        bloc: BlocProvider(
          create: (_) => WelcomeBloc(),
        ),
      ),
    ];
  }

  static List<dynamic> allBlocProviders(BuildContext context) {
    List<dynamic> blocProviders = <dynamic>[];
    for (var bloc in routes()) {
      blocProviders.add(bloc.bloc);
    }
    return blocProviders;
  }

  ///a modal that covers entire screen as we click on a navigator object
  static MaterialPageRoute generateRouteSettings(RouteSettings settings) {
    if (settings.name != null) {
      //check for route name matching when we click on a navigator object
      var results = routes().where((element) => element.route == settings.name);
      if (results.isNotEmpty) {
        //if we have a match, return the page
        print('valid route name ${settings.name}');
        return MaterialPageRoute(
            builder: (_) => results.first.page, settings: settings);
      }
    }
    print('invalid route name ${settings.name}');
    return MaterialPageRoute(
        builder: (_) => const SignInScreen(), settings: settings);
  }
}

/// Unify BlocProvider and routes and pages
class PageEntity {
  String route;
  Widget page;
  dynamic bloc;

  PageEntity({
    required this.route,
    required this.page,
    this.bloc,
  });
}

//curly braces is optional parameter
//with required, you have to add values