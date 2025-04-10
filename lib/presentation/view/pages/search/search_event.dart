part of 'search_bloc.dart';

@freezed
sealed class SearchEvent with _$SearchEvent {
  const factory SearchEvent.loadData() = _LoadData;
  const factory SearchEvent.queryChanged(String query) = _QueryChanged;
  const factory SearchEvent.changeSaveTopic(String index) = _ChangeSaveTopic;
  const factory SearchEvent.changeFollowUser(String userName) = _ChangeFollowUser;

}