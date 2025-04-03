import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/respone/news.dart';
import '../models/respone/user.dart';

part 'news_api.g.dart';

  @RestApi(baseUrl: "https://67e501bf18194932a58410cf.mockapi.io")
abstract class NewsApi {
  factory NewsApi(Dio dio, {String baseUrl}) = _NewsApi;

  @GET("/news/news")
  Future<List<NewsRespone>> getNews();

  @GET("/news/users")
  Future<List<UserRespone>> getUsers();
}