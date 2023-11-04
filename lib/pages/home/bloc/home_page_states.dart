import 'package:yt_ulearning/common/entities/entities.dart';

class HomePageStates {
  final int index;
  final List<CourseItem> courseItem;

  const HomePageStates({
    this.index = 0,
    this.courseItem = const <CourseItem>[],
  });

  HomePageStates copyWith({int? index, List<CourseItem>? courseItem}) {
    return HomePageStates(
      index: index ?? this.index,
      courseItem: courseItem ?? this.courseItem,
    );
  }
}
