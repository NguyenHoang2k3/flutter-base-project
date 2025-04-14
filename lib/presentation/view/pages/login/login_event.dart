part of 'login_bloc.dart';

@freezed
sealed class LoginEvent with _$LoginEvent {
  const factory LoginEvent.loadData() = _LoadData;
  const factory LoginEvent.login({
    required String username,
    required String password,
  }) = _Login;
  const factory LoginEvent.pressGoogleLogin() = _PressGoogleLogin;
}