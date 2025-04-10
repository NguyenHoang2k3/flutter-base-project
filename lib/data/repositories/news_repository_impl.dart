import 'package:flutter_clean_architecture/data/translator/news_translator.dart';
import 'package:flutter_clean_architecture/data/translator/users_translator.dart';
import 'package:flutter_clean_architecture/domain/entities/news.dart';
import 'package:flutter_clean_architecture/domain/entities/users.dart';
import 'package:injectable/injectable.dart';
import '../../domain/repositories/news_repository.dart';
import '../remote/datasources/news_remote_data_source.dart';

@Injectable(as: NewsRepository)
class NewsRepositoryImpl extends NewsRepository {
  NewsRepositoryImpl(this._newsRemoteDataSource);
  final NewsRemoteDataSource _newsRemoteDataSource;

  @override
  Future<List<News>> getNews() async {
    final response = await _newsRemoteDataSource.getNews();

    return response.map((e) => e.toEntity()).toList();
  }

  @override
  Future<List<Users>> getUsers() async {
    final response = await _newsRemoteDataSource.getUsers();

    return response.map((e) => e.toEntity()).toList();
  }

  @override
  Future<List<Users>> getUsersBySearch(String key) async {
    final response = await _newsRemoteDataSource.getUsers();

    List<Users> filterdUser = response.map((e) => e.toEntity()).toList()
        .where((user) =>
        user.username.trim().toLowerCase().contains(key.trim().toLowerCase()))
        .toList();
        return filterdUser;
  }
  @override
  Future<List<News>> getNewsBySearch(String key) async {
    final response = await _newsRemoteDataSource.getNews();

    List<News> filterdNews = response.map((e) => e.toEntity()).toList()
        .where((news) =>
        news.title.trim().toLowerCase().contains(key.trim().toLowerCase()))
        .toList();
    return filterdNews;
  }

  @override
  Future<bool> changeFollows(String userName) async {
    final response = await _newsRemoteDataSource.getUsers();
    List<Users> users = response.map((e) => e.toEntity()).toList();
    final index = users.indexWhere((user) => user.username == userName);
    if (index != -1) {
      final updatedUser = users[index].copyWith(isFollow: !users[index].isFollow);
      users[index] = updatedUser;
    }

    return true;
  }
}