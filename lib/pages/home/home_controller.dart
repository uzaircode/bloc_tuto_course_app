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
    var result = await CourseAPI.courseList();
    if (result.code == 200) {
      context.read<HomePageBlocs>().add(HomePageCourseItem(result.data!));
      print("perfect");
    } else {
      print(result.code);
    }
  }
}
