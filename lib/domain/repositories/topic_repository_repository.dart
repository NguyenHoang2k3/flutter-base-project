import 'package:flutter_clean_architecture/domain/entities/topics.dart';

abstract class TopicRepositoryRepository {
  Future<List<Topics>> getListTopic(String key);
  Future<List<Topics>> getListTopics();
  Future<bool> changeSaveTopic(String topicName);
}