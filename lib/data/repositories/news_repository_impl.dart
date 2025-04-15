import 'package:flutter_clean_architecture/data/translator/news_translator.dart';
import 'package:flutter_clean_architecture/data/translator/users_translator.dart';
import 'package:flutter_clean_architecture/domain/entities/news.dart';
import 'package:flutter_clean_architecture/domain/entities/users.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/repositories/news_repository.dart';
import '../../shared/common/error_entity/business_error_entity.dart';
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
        (user.username??'').trim().toLowerCase().contains(key.trim().toLowerCase()))
        .toList();
        return filterdUser;
  }
  @override
  Future<List<News>> getNewsBySearch(String key) async {
    final response = await _newsRemoteDataSource.getNews();

    List<News> filterdNews = response.map((e) => e.toEntity()).toList()
        .where((news) =>
    (news.title??'').trim().toLowerCase().contains(key.trim().toLowerCase()))
        .toList();
    return filterdNews;
  }

  @override
  Future<News?> getNewsById(String id) async {
    final response = await _newsRemoteDataSource.getNews();

    final newsList = response.map((e) => e.toEntity()).toList();

    try {
      return newsList.firstWhere(
            (news) => (news.id??'').trim().toLowerCase() == id.trim().toLowerCase(),
      );
    } catch (e) {
      return null;
    }
  }


  @override
  Future<bool> changeFollows(String userName) async {
    final response = await _newsRemoteDataSource.getUsers();
    List<Users> users = response.map((e) => e.toEntity()).toList();
    final user = users.firstWhere((user) => user.username == userName);
    user.isFollow = !user.isFollow;

    return true;
  }

  @override
  Future<bool> changeLikeForCurrentUser(String newsId) async {
    try{
      final response = await _newsRemoteDataSource.getNews();

      final newsList = response.map((e) => e.toEntity()).toList();
      News news = newsList.firstWhere((news)=> news.id == newsId);

      String? userIdLiked = news.userLikeId.firstWhere((userId)=> userId == news.id,orElse: () => '');
      if(userIdLiked != ''){
        news.userLikeId.remove(userIdLiked);
        return false;
      }
      else{
        news.userLikeId.add(news.id ?? '');
        return true;
      }
    }
    catch(e){
      throw BusinessErrorEntityData(name: 'có lỗi trong lúc thay đổi like', message: 'có lỗi trong lúc thay đổi like');
    }
  }

  @override
  Future<bool> checkLikeForCurrentUser(String newsId) async {
    try{
      final response = await _newsRemoteDataSource.getNews();

      final newsList = response.map((e) => e.toEntity()).toList();
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      News news = newsList.firstWhere((news)=> news.id == newsId);
      /*String? currentUserId = prefs.getString('currentUserId');*/
      return news.userLikeId.any((id)=> id == news.id);
    }
    catch(e){
      throw BusinessErrorEntityData(name: 'lỗi khi check like', message: 'lỗi khi check like');
    }

  }

  @override
  Future<List<News>> getNewsOfCurrentUser() {
    // TODO: implement getNewsOfCurrentUser
    throw UnimplementedError();
  }
}