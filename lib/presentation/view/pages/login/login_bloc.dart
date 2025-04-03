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
          emit(state.copyWith(pageStatus: PageStatus.Loaded,usersList: users));
        } else if (event is _Login) {
          // Xử lý logic đăng nhập
          final username = event.username;
          final password = event.password;

          // Ví dụ: Kiểm tra username và password
          if (username.isEmpty || password.isEmpty) {
            emit(state.copyWith(
              pageStatus: PageStatus.Error,
              pageErrorMessage: 'Username or password cannot be empty',
            ));
          } else {
            // Gửi yêu cầu đăng nhập hoặc xử lý logic khác
            emit(state.copyWith(pageStatus: PageStatus.Loaded));
          }
        }
      } catch (e, s) {
        handleError(emit, ErrorConverter.convert(e, s));
      }
    });
  }
  final GetUsersListUseCase _getUsersListUseCase;
}