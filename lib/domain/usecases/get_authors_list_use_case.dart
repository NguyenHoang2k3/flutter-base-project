import 'package:flutter_clean_architecture/domain/entities/users.dart';
import 'package:injectable/injectable.dart';

import '../repositories/news_repository.dart';
import 'use_case.dart';

@injectable
class GetAuthorsListUseCaseUseCase extends UseCase<List<Users>, GetAuthorsListUseCaseParam> {
  GetAuthorsListUseCaseUseCase(this._newsRepository);
  final NewsRepository _newsRepository;

  @override
  Future<List<Users>> call({required GetAuthorsListUseCaseParam params}) async {
    return _newsRepository.getUsers();
  }

}

class GetAuthorsListUseCaseParam {
  GetAuthorsListUseCaseParam({required String query});
}