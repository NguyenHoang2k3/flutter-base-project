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
}