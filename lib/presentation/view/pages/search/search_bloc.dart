import 'package:flutter_clean_architecture/domain/entities/users.dart';
import 'package:flutter_clean_architecture/domain/usecases/change_follow_use_case.dart';
import 'package:flutter_clean_architecture/domain/usecases/change_save_topic_use_case.dart';
import 'package:flutter_clean_architecture/domain/usecases/get_authors_list_use_case.dart';
import 'package:flutter_clean_architecture/domain/usecases/get_search_news_use_case.dart';
import 'package:flutter_clean_architecture/domain/usecases/get_search_user_use_case.dart';
import 'package:flutter_clean_architecture/domain/usecases/get_topics_list_use_case.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../domain/entities/news.dart';
import '../../../../domain/entities/topics.dart';
import '../../../../domain/usecases/get_news_list_use_case.dart';
import '../../../../shared/common/error_converter.dart';
import '../../../base/base_bloc.dart';
import '../../../base/base_state.dart';
import '../../../base/page_status.dart';

part 'search_bloc.freezed.dart';
part 'search_event.dart';
part 'search_state.dart';

@injectable
class SearchBloc extends BaseBloc<SearchEvent, SearchState> {
  SearchBloc(this._getNewsListUseCase, this._getTopicsListUseCase, this._getAuthorsListUseCase, this._getSearchNewsUseCase, this._getSearchUserUseCase, this._changeSaveTopicUseCase, this._changeFollowUseCase) : super(const SearchState()) {
    on<SearchEvent>((event, emit) async {
        try {
          switch(event) {
            case _LoadData():
              emit(state.copyWith(pageStatus: PageStatus.Loaded, isload: true));
              try {
                final news = await _getNewsListUseCase.call(
                  params: GetNewsListParam(),
                );

                final topics = await _getTopicsListUseCase.call(
                  params: GetTopicsListUseCaseParam(''),
                );

                final authors = await _getAuthorsListUseCase.call(
                  params: GetAuthorsListUseCaseParam(query: ''),
                );
                emit(state.copyWith(
                  listNews: news,
                  listTopics: topics,
                  listUsers: authors, isload: false
                ));
              } catch (e, s) {
                handleError(emit, ErrorConverter.convert(e, s));
              }
              break;
            case _QueryChanged(:final query):
              emit(state.copyWith(query: query));

              // Lọc danh sách News
              final filteredNews = await _getSearchNewsUseCase.call(
                params: GetSearchNewsParam(query),
              );
              emit(state.copyWith(listNews: filteredNews));

              // Lọc danh sách Topics
              final filteredTopics = await _getTopicsListUseCase.call(
                params: GetTopicsListUseCaseParam(query),
              );
              emit(state.copyWith(listTopics: await filteredTopics));

              // Lọc danh sách Authors
              final filteredAuthors = await _getSearchUserUseCase.call(
                params: GetSearchUserParam(query),
              );
              emit(state.copyWith(listUsers: await filteredAuthors));
              break;
            case _ChangeSaveTopic(:final index):
              await _changeSaveTopicUseCase.call(params: ChangeSaveTopicParam(index));
              emit(
                state.copyWith(saveTopic: !state.saveTopic),
              );
              break;

            case _ChangeFollowUser(:final userName):
              //await _changeFollowUseCase.call(params: ChangeFollowParam(userName));
              emit(
                state.copyWith(isFollow: !state.isFollow),
              );
              break;
          }
        } catch(e,s) {
            handleError(emit, ErrorConverter.convert(e, s));
        }
    });
  }
  Future<void> _saveTopicState(Topics topic) async {
    final prefs = await SharedPreferences.getInstance();
    final savedTopics = prefs.getStringList('savedTopics') ?? [];
    if (topic.save) {
      savedTopics.add(topic.id);
    } else {
      savedTopics.remove(topic.id);
    }
    await prefs.setStringList('savedTopics', savedTopics);
  }

  Future<void> _saveUserFollowState(Users user) async {
    final prefs = await SharedPreferences.getInstance();
    final followedUsers = prefs.getStringList('followedUsers') ?? [];
    if (user.isFollow) {
      followedUsers.add(user.username??'');
    } else {
      followedUsers.remove(user.username);
    }
    await prefs.setStringList('followedUsers', followedUsers);
  }
  Future<void> _loadSavedStates() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTopics = prefs.getStringList('savedTopics') ?? [];
    final followedUsers = prefs.getStringList('followedUsers') ?? [];

    final updatedTopics = state.listTopics?.map((topic) {
      return topic.copyWith(save: savedTopics.contains(topic.id));
    }).toList();

    final updatedUsers = state.listUsers?.map((user) {
      return user.copyWith(isFollow: followedUsers.contains(user.username));
    }).toList();

    emit(state.copyWith(listTopics: updatedTopics, listUsers: updatedUsers));
  }
  final GetNewsListUseCase _getNewsListUseCase;
  final GetTopicsListUseCaseUseCase _getTopicsListUseCase;
  final GetAuthorsListUseCaseUseCase _getAuthorsListUseCase;
  final GetSearchNewsUseCase _getSearchNewsUseCase;
  final GetSearchUserUseCase _getSearchUserUseCase;
  final ChangeSaveTopicUseCase _changeSaveTopicUseCase;
  final ChangeFollowUseCase _changeFollowUseCase;
}