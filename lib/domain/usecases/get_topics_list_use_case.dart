import 'package:flutter_clean_architecture/domain/entities/topics.dart';
import 'package:injectable/injectable.dart';

import '../repositories/topic_repository_repository.dart';
import 'use_case.dart';

@injectable
class GetTopicsListUseCaseUseCase extends UseCase<List<Topics>, GetTopicsListUseCaseParam> {
  GetTopicsListUseCaseUseCase(this._topicRepository);
  final TopicRepositoryRepository _topicRepository;
  @override
  Future<List<Topics>> call({required GetTopicsListUseCaseParam params}) async {
    return _topicRepository.getListTopic(params.key);
  }
}

class GetTopicsListUseCaseParam {
  GetTopicsListUseCaseParam(this.key);
  final String key;
}