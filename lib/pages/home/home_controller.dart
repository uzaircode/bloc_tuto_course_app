import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yt_ulearning/common/apis/course_api.dart';
import 'package:yt_ulearning/common/entities/user.dart';
import 'package:yt_ulearning/global.dart';
import 'package:yt_ulearning/pages/home/bloc/home_page_blocs.dart';
import 'package:yt_ulearning/pages/home/bloc/home_page_events.dart';

class HomeController {
  late BuildContext context;
  UserItem get userProfile => Global.storageService.getUserProfile();
  static final HomeController _singleton = HomeController._internal();

  HomeController._internal();

  factory HomeController({required BuildContext context}) {
    _singleton.context = context;
    return _singleton;
  }

  Future<void> init() async {
    //make sure that user is logged in and then make an api call
    if (Global.storageService.getUserToken().isNotEmpty) {
      var result = await CourseAPI.courseList();
      if (result.code == 200) {
        if (context.mounted) {
          context.read<HomePageBlocs>().add(HomePageCourseItem(result.data!));
        }
      } else {
        print(result.code);
      }
    } else {
      print('user has already logged out');
    }
  }
}
