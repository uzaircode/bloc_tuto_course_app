import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yt_ulearning/pages/course/bloc/course_events.dart';
import 'package:yt_ulearning/pages/course/bloc/course_states.dart';

class CourseBloc extends Bloc<CourseEvents, CourseStates> {
  CourseBloc() : super(const CourseStates()) {
    on<TriggerCourse>(_onTriggerCourseDetail);
  }

  void _onTriggerCourseDetail(TriggerCourse event, Emitter emit) {
    emit(state.copyWith(courseItem: event.courseItem));
  }
}
