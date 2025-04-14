import 'package:flutter_clean_architecture/domain/entities/current_user.dart';
import 'package:flutter_clean_architecture/domain/repositories/author_repository_repository.dart';
import 'package:injectable/injectable.dart';

import 'use_case.dart';

@injectable
class GetCurrentUserUseCase extends UseCase<void, GetCurrentUserParam> {
  GetCurrentUserUseCase(this._authRepository);
  AuthorRepositoryRepository _authRepository;
  @override
  Future<CurrentUser> call({required GetCurrentUserParam params}) async {
    return _authRepository.getCurrentUser();
  }
}

class GetCurrentUserParam {
  GetCurrentUserParam();
}