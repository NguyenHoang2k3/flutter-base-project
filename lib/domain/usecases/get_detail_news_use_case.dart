import 'package:injectable/injectable.dart';

import '../entities/news.dart';
import '../repositories/news_repository.dart';
import 'use_case.dart';

@injectable
class GetDetailNewsUseCase extends UseCase<News?, GetDetailNewsParam> {
  GetDetailNewsUseCase(this._newsRepository);
  final NewsRepository _newsRepository;

  @override
  Future<News?> call({required GetDetailNewsParam params}) {
    return _newsRepository.getNewsById(params.key);
  }

}

class GetDetailNewsParam {
  GetDetailNewsParam(this.key);
  final String key;
}