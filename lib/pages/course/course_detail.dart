import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yt_ulearning/common/values/colors.dart';
import 'package:yt_ulearning/common/widgets/base_text_widget.dart';
import 'package:yt_ulearning/pages/course/widgets/course_detail_widgets.dart';

class CourseDetail extends StatefulWidget {
  const CourseDetail({super.key});

  @override
  State<CourseDetail> createState() => _CourseDetailState();
}

class _CourseDetailState extends State<CourseDetail> {
  late var id;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    id = ModalRoute.of(context)!.settings.arguments as Map;
    print(id.values.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: buildAppBar(),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.h, horizontal: 25.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        thumbnail(),
                        SizedBox(height: 15.h),
                        menuView(),
                        SizedBox(height: 15.h),
                        reusableText("Course Description"),
                        SizedBox(height: 15.h),
                        descriptionText(
                            "Flutter is different than most other options for building mobile apps because it doesn’t rely on web browser technology nor the set of widgets that ship with each device. Instead, Flutter uses its own high-performance rendering engine to draw widgets. In addition, Flutter is different because it only has a thin layer of C/C++ code."),
                        SizedBox(height: 20.h),
                        goBuyButton("Go Buy"),
                        SizedBox(height: 20.h),
                        courseSummaryTitle(),
                        courseSummaryView(context),
                        SizedBox(height: 15.h),
                        reusableText("Lesson List"),
                        SizedBox(height: 15.h),
                        courseLessonList(),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
