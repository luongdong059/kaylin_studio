import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(_Login()) {
    on<LoginEvent>((event, emit) {
      event.when(click: () async {
        emit(state.copyWith(count: state.count + 1));
      }, started: () async {
        emit(state.copyWith(isShow: !state.isShow));
      });
    });
  }
}


