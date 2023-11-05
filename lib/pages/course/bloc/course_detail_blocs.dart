import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yt_ulearning/common/entities/entities.dart';
import 'package:yt_ulearning/pages/course/bloc/course_detail_events.dart';
import 'package:yt_ulearning/pages/course/bloc/course_detail_states.dart';

class CourseDetailBloc extends Bloc<CourseDetailEvents, CourseDetailStates> {
  CourseDetailBloc() : super(const CourseDetailStates()) {
    on<TriggerCourseDetail>(_onTriggerCourseDetail);
  }

  void _onTriggerCourseDetail(TriggerCourseDetail event, Emitter emit) {
    emit(state.copyWith(courseItem: event.courseItem));
  }
}
