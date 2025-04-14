import 'package:injectable/injectable.dart';

import '../repositories/author_repository_repository.dart';
import 'use_case.dart';
@injectable
class LoginByGoogleUseCase extends UseCase<void, LoginByGoogleParam> {
  LoginByGoogleUseCase(this._authRepository);
  final AuthorRepositoryRepository _authRepository;

  @override
  Future<bool> call({required LoginByGoogleParam params})  {
    return _authRepository.loginByGoogle();
  }
}

class LoginByGoogleParam {
  LoginByGoogleParam();
}