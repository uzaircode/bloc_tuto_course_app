import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:yt_ulearning/common/values/colors.dart';
import 'package:yt_ulearning/pages/home/home_page.dart';
import 'package:yt_ulearning/pages/profile/profile_page.dart';

Widget buildPage(int index) {
  List<Widget> _widget = [
    const HomePage(),
    const Center(child: Text("Search")),
    const Center(child: Text("Course")),
    const Center(child: Text("Chat")),
    const ProfilePage(),
  ];
  return _widget[index];
}

var bottomTabs = [
  BottomNavigationBarItem(
    label: 'Home',
    icon: Icon(
      Icons.home_outlined,
    ),
    activeIcon: Icon(
      Icons.home_outlined,
      color: AppColors.primaryElement,
    ),
  ),
  BottomNavigationBarItem(
    label: 'Search',
    icon: Icon(
      Icons.search_outlined,
    ),
    activeIcon: Icon(
      Icons.search_outlined,
      color: AppColors.primaryElement,
    ),
  ),
  BottomNavigationBarItem(
    label: 'Course',
    icon: Icon(
      Icons.book_outlined,
    ),
    activeIcon: Icon(
      Icons.book_outlined,
      color: AppColors.primaryElement,
    ),
  ),
  BottomNavigationBarItem(
    label: 'Chat',
    icon: Icon(
      Icons.chat_outlined,
    ),
    activeIcon: Icon(
      Icons.chat_outlined,
      color: AppColors.primaryElement,
    ),
  ),
  BottomNavigationBarItem(
    label: 'Profile',
    icon: Icon(
      Icons.person_outline,
    ),
    activeIcon: Icon(
      Icons.person_outline,
      color: AppColors.primaryElement,
    ),
  ),
];
