import 'package:flutter/material.dart';
import 'package:yt_ulearning/common/apis/course_api.dart';
import 'package:yt_ulearning/common/entities/user.dart';
import 'package:yt_ulearning/global.dart';

class HomeController {
  final BuildContext context;
  UserItem? userProfile = Global.storageService.getUserProfile();

  HomeController({required this.context});

  Future<void> init() async {
    await CourseAPI.courseList();
  }
}
