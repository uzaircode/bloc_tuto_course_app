import 'package:flutter/material.dart';
import 'package:yt_ulearning/common/entities/user.dart';
import 'package:yt_ulearning/common/service/storage_service.dart';
import 'package:yt_ulearning/global.dart';

class HomeController {
  final BuildContext context;
  HomeController({required this.context});

  UserItem userProfile = Global.storageService.getUserProfile();

  void init() {
    print("...home controller init method...");
  }
}
