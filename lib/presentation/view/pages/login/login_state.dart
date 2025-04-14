part of 'login_bloc.dart';

@freezed
class LoginState extends BaseState with _$LoginState {
  const LoginState({
    super.pageStatus = PageStatus.Loaded,
    super.pageErrorMessage,
    this.usersList = const [],
    this.isLoggedIn = false,
  });
  final List<Users> usersList;
  final bool isLoggedIn;

}