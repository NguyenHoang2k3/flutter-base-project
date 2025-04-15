part of 'detail_news_bloc.dart';

@freezed
sealed class DetailNewsEvent with _$DetailNewsEvent {
  const factory DetailNewsEvent.loadData() = _LoadData;
  const factory DetailNewsEvent.loadDataDetail(String newsId) = _LoadDataDetail;
  const factory DetailNewsEvent.changeLike() = _ChangeLike;
  const factory DetailNewsEvent.changeSave() = _ChangeSave;
  const factory DetailNewsEvent.changeFollow(String userName) = _ChangeFollow;
}