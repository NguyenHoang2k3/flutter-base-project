part of 'search_bloc.dart';

@freezed
class SearchState extends BaseState with _$SearchState {
  const SearchState({
    super.pageStatus = PageStatus.Loaded,
    super.pageErrorMessage,
    this.query = '',
    this.listNews,
    this.listTopics,
    this.listUsers,
    this.isFollow = false,
    this.saveTopic = false,
  });

  @override
  final List<News>? listNews;

  @override
  final List<Topics>? listTopics;
  @override
  final List<Users>? listUsers;

  @override
  final String query;
  @override
  final bool isFollow;
  @override
  final bool saveTopic;
}
