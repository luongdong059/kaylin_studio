part of 'login_bloc.dart';

@freezed
abstract class LoginState with _$LoginState {
  const factory LoginState.login({
    @Default(0) int count,
    @Default(false) bool isShow,
    @Default(null) int? number,
  }) = _Login;
}
