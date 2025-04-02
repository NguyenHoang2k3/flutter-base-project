import 'package:flutter_clean_architecture/domain/repositories/news_repository.dart';
import 'package:injectable/injectable.dart';

import '../entities/news.dart';
import 'use_case.dart';

@injectable
class GetNewsListUseCase extends UseCase<List<News>, GetNewsListParam> {
  GetNewsListUseCase(this._newsRepository);
  final NewsRepository _newsRepository;

  @override
  Future<List<News>> call({required GetNewsListParam params}) async {
    return _newsRepository.getNews();
  }
}

class GetNewsListParam {
  GetNewsListParam();
}