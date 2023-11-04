import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yt_ulearning/common/routes/names.dart';
import 'package:yt_ulearning/global.dart';
import 'package:yt_ulearning/pages/application/application_page.dart';
import 'package:yt_ulearning/pages/application/bloc/app_blocs.dart';
import 'package:yt_ulearning/pages/home/bloc/home_page_blocs.dart';
import 'package:yt_ulearning/pages/home/home_page.dart';
import 'package:yt_ulearning/pages/profile/settings/bloc/settings_blocs.dart';
import 'package:yt_ulearning/pages/profile/settings/settings_page.dart';
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
        page: const ApplicationPage(),
        bloc: BlocProvider(
          create: (_) => AppBlocs(),
        ),
      ),
      PageEntity(
        route: AppRoutes.HOME_PAGE,
        page: const HomePage(),
        bloc: BlocProvider(
          create: (_) => HomePageBlocs(),
        ),
      ),
      PageEntity(
        route: AppRoutes.SETTING_PAGE,
        page: const SettingsPage(),
        bloc: BlocProvider(
          create: (_) => SettingsBlocs(),
        ),
      )
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
      var result = routes().where((element) => element.route == settings.name);
      if (result.isNotEmpty) {
        print(result.first.route);
        //if we have a match, return the page
        bool deviceFirstOpen = Global.storageService.getDeviceFirstOpen();

        if (result.first.route == AppRoutes.INITIAL && deviceFirstOpen) {
          bool isLoggedin = Global.storageService.getIsLoggedIn();

          if (isLoggedin) {
            // Application screen
            return MaterialPageRoute(
                builder: (context) => const ApplicationPage(),
                settings: settings);
          }
          // Sign-in screen
          return MaterialPageRoute(
              builder: (context) => const SignInScreen(), settings: settings);
        }
        // On-boarding screen
        return MaterialPageRoute(
            builder: (_) => result.first.page, settings: settings);
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