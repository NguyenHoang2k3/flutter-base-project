import 'package:flutter_clean_architecture/domain/entities/users.dart';
import 'package:flutter_clean_architecture/domain/usecases/get_users_list_use_case.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../shared/common/error_converter.dart';
import '../../../base/base_bloc.dart';
import '../../../base/base_state.dart';
import '../../../base/page_status.dart';

part 'login_bloc.freezed.dart';
part 'login_event.dart';
part 'login_state.dart';

@injectable
class LoginBloc extends BaseBloc<LoginEvent, LoginState> {
  LoginBloc(this._getUsersListUseCase) : super(const LoginState()) {
    on<LoginEvent>((event, emit) async {
      try {
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
            );

            if (user != null) {
              emit(state.copyWith(
                pageStatus: PageStatus.Loaded,
                isLoggedIn: true,
                pageErrorMessage: 'Login successful!', // Thông báo thành công
              ));
            } else {
              emit(state.copyWith(
                pageStatus: PageStatus.Error,
                pageErrorMessage: 'Invalid username or password', // Thông báo thất bại
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
}