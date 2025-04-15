
import '../entities/news.dart';
import '../entities/users.dart';

abstract class NewsRepository {
  Future<List<News>> getNews();
  Future<List<Users>> getUsers();
  Future<List<Users>> getUsersBySearch(String key);
  Future<List<News>> getNewsBySearch(String key);
  Future<bool> changeFollows(String userName);
  Future<News?> getNewsById(String id);
  Future<bool> checkLikeForCurrentUser(String newsId);
  Future<bool> changeLikeForCurrentUser(String newsId);
  Future<List<News>> getNewsOfCurrentUser();

}