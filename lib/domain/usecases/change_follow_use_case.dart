import 'package:flutter_clean_architecture/domain/repositories/news_repository.dart';
import 'package:injectable/injectable.dart';

import 'use_case.dart';

@injectable
class ChangeFollowUseCase extends UseCase<bool, ChangeFollowParam> {
  ChangeFollowUseCase(this._newsRepository);
  final NewsRepository _newsRepository;

  @override
  Future<bool> call({required ChangeFollowParam params}) async {
    return _newsRepository.changeFollows(params.key);
  }
}

class ChangeFollowParam {
  ChangeFollowParam(this.key);
  final String key;
}