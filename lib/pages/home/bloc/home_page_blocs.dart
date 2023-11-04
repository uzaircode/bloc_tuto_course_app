import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yt_ulearning/pages/home/bloc/home_page_events.dart';
import 'package:yt_ulearning/pages/home/bloc/home_page_states.dart';

class HomePageBlocs extends Bloc<HomePageEvents, HomePageStates> {
  HomePageBlocs() : super(const HomePageStates()) {
    on<HomePageDots>(_HomePageDots);
    on<HomePageCourseItem>(_HomePageCourseItem);
  }

  void _HomePageDots(HomePageDots event, Emitter<HomePageStates> emit) {
    emit(state.copyWith(index: event.index));
  }

  void _HomePageCourseItem(
      HomePageCourseItem event, Emitter<HomePageStates> emit) {
    emit(state.copyWith(courseItem: event.courseItem));
  }
}
