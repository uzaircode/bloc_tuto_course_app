import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yt_ulearning/pages/application/bloc/app_events.dart';
import 'package:yt_ulearning/pages/application/bloc/app_states.dart';

class AppBlocs extends Bloc<AppEvent, AppState> {
  AppBlocs() : super(const AppState()) {
    on<TriggerAppEvent>((event, emit) {
      print("my tapped index is ${event.index}");
      emit(AppState(index: event.index));
    });
  }
}
