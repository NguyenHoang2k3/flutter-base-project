part of 'detail_news_bloc.dart';

@freezed
class DetailNewsState extends BaseState with _$DetailNewsState {
  const DetailNewsState( {
    super.pageStatus = PageStatus.Loaded,
    super.pageErrorMessage,
    this.followState= false,
    this.likeState = false,
    this.newsDetail,
    this.saveState = false,
    this.numberComment = 0,
  });
  final News? newsDetail;
  @override
  final bool followState;
  @override
  final bool likeState;
  @override
  final bool saveState;
  @override
  final int numberComment;
}