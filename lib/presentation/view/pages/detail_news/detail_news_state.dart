part of 'detail_news_bloc.dart';

@freezed
class DetailNewsState extends BaseState with _$DetailNewsState {
  const DetailNewsState( {
    super.pageStatus = PageStatus.Loaded,
    super.pageErrorMessage,
    this.newsDetail,
  });
  final News? newsDetail;
}