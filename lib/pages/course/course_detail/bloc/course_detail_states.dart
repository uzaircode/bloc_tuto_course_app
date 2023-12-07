import 'package:yt_ulearning/common/entities/course.dart';

class CourseDetailStates {
  const CourseDetailStates({this.courseItem});

  final CourseItem? courseItem;

  CourseDetailStates copyWith({CourseItem? courseItem}) {
    return CourseDetailStates(
      courseItem: courseItem ?? this.courseItem,
    );
  }
}
