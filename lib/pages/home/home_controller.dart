import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yt_ulearning/common/apis/course_api.dart';
import 'package:yt_ulearning/common/entities/user.dart';
import 'package:yt_ulearning/global.dart';
import 'package:yt_ulearning/pages/home/bloc/home_page_blocs.dart';
import 'package:yt_ulearning/pages/home/bloc/home_page_events.dart';

class HomeController {
  final BuildContext context;
  UserItem userProfile = Global.storageService.getUserProfile();

  HomeController({required this.context});

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
