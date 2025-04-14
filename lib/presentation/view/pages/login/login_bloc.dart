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
        if(event == _PressGoogleLogin()) {
          print('bloc---------------------');
          bool loginSuccess = await _loginByGoogleUseCase.call(params: LoginByGoogleParam());
          if (loginSuccess) {
            emit(state.copyWith(isLoggedIn: true));
          } else {
            emit(state.copyWith(
              pageStatus: PageStatus.Error,
              pageErrorMessage: 'Google login failed: Unable to authenticate',
            ));
          }
        }
        if (event == _LoadData()) {
          final users = await _getUsersListUseCase.call(params: GetUsersListParam());
          emit(state.copyWith(pageStatus: PageStatus.Loaded, usersList: users));
        } else if (event is _Login) {
          final username = event.username;
          final password = event.password;

          if (username.isEmpty || password.isEmpty) {
            emit(state.copyWith(
              pageStatus: PageStatus.Error,
              pageErrorMessage: 'Username or password cannot be empty',
            ));
          } else {
            final user = state.usersList.firstWhere(
                  (user) => user.username == username && user.password == password,
              orElse: () => throw Exception('Invalid username or password'),
            );

            if (user != null) {
              final currentUser = CurrentUser(
                user.id ?? '',
                '',
                user.imageUrl,
                 user.username??'',
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
            } else {
              emit(state.copyWith(
                pageStatus: PageStatus.Error,
                pageErrorMessage: 'Invalid username or password',
              ));
            }
          }
        }
      } catch (e, s) {
        handleError(emit, ErrorConverter.convert(e, s));
      }
    });
  }

  final GetUsersListUseCase _getUsersListUseCase;
  final LoginByGoogleUseCase _loginByGoogleUseCase;
  ///lưu currnentUser
  Future<void> _saveUserToPreferences(CurrentUser user) async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = jsonEncode(user.toJson());
    await prefs.setString('currentUser', userJson);
  }
}