
import '../entities/news.dart';
import '../entities/users.dart';

abstract class NewsRepository {
  Future<List<News>> getNews();
  Future<List<Users>> getUsers();
}