import 'package:flutter_clean_architecture/domain/repositories/topic_repository_repository.dart';
import 'package:injectable/injectable.dart';

import 'use_case.dart';

@injectable
class ChangeSaveTopicUseCase extends UseCase<bool, ChangeSaveTopicParam> {
  ChangeSaveTopicUseCase(this._topicRepository);
  final TopicRepositoryRepository _topicRepository;
  @override
  Future<bool> call({required ChangeSaveTopicParam params}) async {
    return _topicRepository.changeSaveTopic(params.key);
  }
}

class ChangeSaveTopicParam {
  ChangeSaveTopicParam(this.key);
  final String key;
}