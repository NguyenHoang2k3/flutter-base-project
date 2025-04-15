import 'package:flutter_clean_architecture/domain/entities/topics.dart';
import 'package:injectable/injectable.dart';
import '../../domain/repositories/topic_repository_repository.dart';

@Injectable(as: TopicRepositoryRepository)
class TopicRepositoryRepositoryImpl extends TopicRepositoryRepository {
  TopicRepositoryRepositoryImpl();

  @override
  Future<bool> changeSaveTopic(String topicName) async {
    Topics topic = _topics.firstWhere((topic)=> topic.id == topicName);
    topic.save = !topic.save;
    return true;
  }

  @override
  Future<List<Topics>> getListTopic(String key) async {
    List<Topics> filteredTopics = _topics
        .where((topic) =>
        topic.name.trim().toLowerCase().contains(key.trim().toLowerCase()))
        .toList();
    return filteredTopics;
  }

  @override
  Future<List<Topics>> getListTopics() {
    // TODO: implement getListTopicSaved
    throw UnimplementedError();
  }
  static List<Topics> _topics  = [
    Topics(
        id: "1",
        imageUrl: "assets/images/health.png",
        name: "Health",
        context: "Stay updated with the latest in health, fitness, and wellness.",
        save: true
    ),
    Topics(
        id: "2",
        imageUrl: "assets/images/health.png",
        name: "Technology",
        context: "Discover the newest innovations and tech trends shaping the world.",
        save: false
    ),
    Topics(
        id: "3",
        imageUrl: "assets/images/health.png",
        name: "Science",
        context: "Explore scientific discoveries and research breakthroughs.",
        save: true
    ),
    Topics(
        id: "4",
        imageUrl: "assets/images/health.png",
        name: "Travel",
        context: "Get inspired by travel guides and explore destinations worldwide.",
        save: true
    ),
    Topics(
        id: "5",
        imageUrl: "assets/images/health.png",
        name: "Education",
        context: "Read about new learning methods, policies, and global education news.",
        save: false
    ),
    Topics(
        id: "6",
        imageUrl: "assets/images/health.png",
        name: "Finance",
        context: "Track market trends, financial tips, and economic updates.",
        save: false
    ),
    Topics(
        id: "7",
        imageUrl: "assets/images/health.png",
        name: "Lifestyle",
        context: "Find insights on relationships, personal growth, and daily living.",
        save: true
    ),
    Topics(
        id: "8",
        imageUrl: "assets/images/health.png",
        name: "Environment",
        context: "Learn about climate change, conservation, and sustainability.",
        save: true
    ),
    Topics(
        id: "9",
        imageUrl: "assets/images/health.png",
        name: "Culture",
        context: "Dive into art, literature, and traditions around the globe.",
        save: false
    ),
    Topics(
        id: "10",
        imageUrl: "assets/images/health.png",
        name: "Food",
        context: "Discover delicious recipes, food trends, and culinary tips.",
        save: true
    ),

  ];
}