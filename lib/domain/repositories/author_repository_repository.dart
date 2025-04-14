import '../../data/remote/models/respone/login_info_response.dart';
import '../entities/current_user.dart';

abstract class AuthorRepositoryRepository {
  Future<CurrentUser> login(
      {required String username, required String password,required bool isRemember});

  Future<CurrentUser> getCurrentUser();

  Future<bool> loginByGoogle();

  Future<LoginInfoResponse> checkRememberPassword();
}