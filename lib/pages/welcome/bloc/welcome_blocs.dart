import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yt_ulearning/pages/welcome/bloc/welcome_events.dart';
import 'package:yt_ulearning/pages/welcome/bloc/welcome_states.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  WelcomeBloc() : super(WelcomeState()) {
    on<WelcomeEvent>((event, emit) {
      emit(WelcomeState(page: state.page));
    });
  }
}
