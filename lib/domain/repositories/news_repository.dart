
import '../entities/news.dart';
import '../entities/users.dart';

abstract class NewsRepository {
  Future<List<News>> getNews();
  Future<List<Users>> getUsers();
  Future<List<Users>> getUsersBySearch(String key);
  Future<List<News>> getNewsBySearch(String key);
  Future<bool> changeFollows(String userName);

}