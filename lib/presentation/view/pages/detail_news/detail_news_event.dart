part of 'detail_news_bloc.dart';

@freezed
sealed class DetailNewsEvent with _$DetailNewsEvent {
  const factory DetailNewsEvent.loadData() = _LoadData;
}