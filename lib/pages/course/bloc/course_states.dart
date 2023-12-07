import 'package:yt_ulearning/common/entities/course.dart';

class CourseStates {
  const CourseStates({this.courseItem});

  final CourseItem? courseItem;

  CourseStates copyWith({CourseItem? courseItem}) {
    return CourseStates(
      courseItem: courseItem ?? this.courseItem,
    );
  }
}
