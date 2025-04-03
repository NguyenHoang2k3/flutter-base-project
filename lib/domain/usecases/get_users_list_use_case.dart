import 'package:injectable/injectable.dart';

import '../entities/users.dart';
import '../repositories/news_repository.dart';
import 'use_case.dart';

@injectable
class GetUsersListUseCase extends UseCase<List<Users>, GetUsersListParam> {
  GetUsersListUseCase(this._newsRepository);
  final NewsRepository _newsRepository;

  @override
  Future<List<Users>> call({required GetUsersListParam params}) {
    return _newsRepository.getUsers();
  }

}

class GetUsersListParam {
  GetUsersListParam();
}