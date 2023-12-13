part of 'app_cubit.dart';

@freezed
class AppState with _$AppState {
  const factory AppState.initial({@Default(false) bool isDarkMode}) = _Initial;
}
