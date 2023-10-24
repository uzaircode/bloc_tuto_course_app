import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yt_ulearning/pages/home/bloc/homepage_events.dart';
import 'package:yt_ulearning/pages/home/bloc/homepage_states.dart';

class HomePageBlocs extends Bloc<HomePageEvents, HomePageStates> {
  HomePageBlocs() : super(const HomePageStates()) {
    on<HomePageDots>(_HomePageDots);
  }

  void _HomePageDots(HomePageDots event, Emitter<HomePageStates> emit) {
    emit(state.copyWith(index: event.index));
  }
}
