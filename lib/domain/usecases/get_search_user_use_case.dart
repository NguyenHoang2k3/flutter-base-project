import 'package:injectable/injectable.dart';

import '../entities/users.dart';
import '../repositories/news_repository.dart';
import 'use_case.dart';


@injectable
class GetSearchUserUseCase extends UseCase<List<Users>, GetSearchUserParam> {
  GetSearchUserUseCase(this._newsRepository);
  final NewsRepository _newsRepository;

  @override
  Future<List<Users>> call({required GetSearchUserParam params}) {
    return _newsRepository.getUsersBySearch(params.key);
  }
}

class GetSearchUserParam {
  GetSearchUserParam(this.key);
  final String key;
}