import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yt_ulearning/common/values/colors.dart';
import 'package:yt_ulearning/pages/home/widgets/home_page_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 0, horizontal: 25.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            homePageText('Hello',
                color: AppColors.primaryThreeElementText, top: 20),
            homePageText('Nik Uzair', color: AppColors.primaryElement, top: 5),
            SizedBox(height: 20.h),
            searchView(),
            slidersView(),
          ],
        ),
      ),
    );
  }
}
