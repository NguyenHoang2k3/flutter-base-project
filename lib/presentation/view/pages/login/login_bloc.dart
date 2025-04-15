import 'package:flutter_clean_architecture/domain/entities/users.dart';
import 'package:flutter_clean_architecture/domain/entities/current_user.dart';
import 'package:flutter_clean_architecture/domain/usecases/get_users_list_use_case.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../../../domain/usecases/login_by_google_use_case.dart';
import '../../../../shared/common/error_converter.dart';
import '../../../base/base_bloc.dart';
import '../../../base/base_state.dart';
import '../../../base/page_status.dart';

part 'login_bloc.freezed.dart';
part 'login_event.dart';
part 'login_state.dart';
@injectable
class LoginBloc extends BaseBloc<LoginEvent, LoginState> {
  LoginBloc(this._getUsersListUseCase, this._loginByGoogleUseCase) : super(const LoginState()) {
    on<LoginEvent>((event, emit) async {
      try {
        switch (event) {
          case _PressGoogleLogin():
            final success = await _loginByGoogleUseCase.call(params: LoginByGoogleParam());
            if (success) {
              emit(state.copyWith(isLoggedIn: true));
            } else {
              emit(state.copyWith(
                pageStatus: PageStatus.Error,
                pageErrorMessage: 'Google login failed: Unable to authenticate',
              ));
            }
            break;

          case _LoadData():
            final users = await _getUsersListUseCase.call(params: GetUsersListParam());
            emit(state.copyWith(
              pageStatus: PageStatus.Loaded,
              usersList: users,
            ));
            break;

          case final _Login loginEvent:
            final username = loginEvent.username;
            final password = loginEvent.password;

            if (username.isEmpty || password.isEmpty) {
              emit(state.copyWith(
                pageStatus: PageStatus.Error,
                pageErrorMessage: 'Username or password cannot be empty',
              ));
              return;
            }

            try {
              final user = state.usersList.firstWhere(
                    (u) => u.username == username && u.password == password,
              );

              final currentUser = CurrentUser(
                user.id ?? '',
                'HoangNguyenNhat',
                user.imageUrl,
                user.username ?? '',
                user.email ?? '',
                '',
                null,
                null,
              );

              await _saveUserToPreferences(currentUser);

              emit(state.copyWith(
                pageStatus: PageStatus.Loaded,
                isLoggedIn: true,
                pageErrorMessage: 'Login successful!',
              ));
            } catch (_) {
              emit(state.copyWith(
                pageStatus: PageStatus.Error,
                pageErrorMessage: 'Invalid username or password',
              ));
            }
            break;
        }
      } catch (e, s) {
        handleError(emit, ErrorConverter.convert(e, s));
      }
    });
  }

  final GetUsersListUseCase _getUsersListUseCase;
  final LoginByGoogleUseCase _loginByGoogleUseCase;

  Future<void> _saveUserToPreferences(CurrentUser user) async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = jsonEncode(user.toJson());
    await prefs.setString('currentUser', userJson);
  }
}
