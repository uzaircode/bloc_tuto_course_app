import 'package:yt_ulearning/common/entities/course.dart';

abstract class CourseEvents {
  const CourseEvents();
}

class TriggerCourse extends CourseEvents {
  const TriggerCourse(this.courseItem) : super();

  final CourseItem courseItem;
}
