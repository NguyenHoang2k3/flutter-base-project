import 'package:flutter_clean_architecture/data/remote/services/news_api.dart';
import 'package:injectable/injectable.dart';

import '../models/respone/news.dart';


@Injectable(as: NewsRemoteDataSource)
class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  NewsRemoteDataSourceImpl(this._newsApi);

  final NewsApi _newsApi;

  @override
  Future<List<NewsRespone>> getNews() {
    return _newsApi.getNews();
  }
}

abstract class NewsRemoteDataSource {
  Future<List<NewsRespone>> getNews();
}

