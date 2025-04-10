import 'package:injectable/injectable.dart';

import '../entities/news.dart';
import '../repositories/news_repository.dart';
import 'use_case.dart';

@injectable
class GetSearchNewsUseCase extends UseCase<List<News>, GetSearchNewsParam> {
  GetSearchNewsUseCase(this._newsRepository);
  final NewsRepository _newsRepository;

  @override
  Future<List<News>> call({required GetSearchNewsParam params}) {
    return _newsRepository.getNewsBySearch(params.key);
  }
}

class GetSearchNewsParam {
  GetSearchNewsParam(this.key);
  final String key;
}