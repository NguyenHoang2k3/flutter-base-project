import 'package:flutter_clean_architecture/domain/usecases/change_follow_use_case.dart';
import 'package:flutter_clean_architecture/domain/usecases/get_detail_news_use_case.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/news.dart';
import '../../../../domain/usecases/change_like_news_for_current_user_use_case.dart';
import '../../../../domain/usecases/check_like_news_for_current_user_use_case.dart';
import '../../../../domain/usecases/count_all_comment_by_news_id_use_case.dart';
import '../../../../shared/common/error_converter.dart';
import '../../../base/base_bloc.dart';
import '../../../base/base_state.dart';
import '../../../base/page_status.dart';

part 'detail_news_bloc.freezed.dart';
part 'detail_news_event.dart';
part 'detail_news_state.dart';

@injectable
class DetailNewsBloc extends BaseBloc<DetailNewsEvent, DetailNewsState> {
  DetailNewsBloc(this._getDetailNewsUseCase,
      this._changeLikeNewsForCurrentUserUseCase,
  this._checkLikeNewsForCurrentUserUseCase,
  this._changeFollowUserUseCase,
  this._countAllCommentByNewsIdUseCase) : super(const DetailNewsState()) {
    on<DetailNewsEvent>((event, emit) async {
        try {
          switch(event) {
            case _LoadData():
              emit(state.copyWith(pageStatus: PageStatus.Loaded));
              break;
            case _LoadDataDetail(:final newsId):
              emit(state.copyWith(pageStatus: PageStatus.Uninitialized));
              final filteredNews = await _getDetailNewsUseCase.call(
                params: GetDetailNewsParam(newsId),
              );
              emit(state.copyWith(pageStatus: PageStatus.Loaded,newsDetail: filteredNews));

            case _ChangeLike():
              await _changeLikeNewsForCurrentUserUseCase.call(
                params: ChangeLikeNewsForCurrentUserParam(
                  state.newsDetail?.id ?? '',
                ),
              );
              bool userLike = await _checkLikeNewsForCurrentUserUseCase.call(
                params: CheckLikeNewsForCurrentUserParam(
                  state.newsDetail?.id ?? '',
                ),
              );
              emit(state.copyWith(likeState: userLike));
            case _ChangeSave():
              emit(state.copyWith(saveState: !state.saveState));
            case _ChangeFollow(: final userName):
              await _changeFollowUserUseCase.call(
                params: ChangeFollowParam(userName),
              );
              emit(state.copyWith(followState: !state.followState));
          }
        } catch(e,s) {
            handleError(emit, ErrorConverter.convert(e, s));
        }
    });
  }
  final GetDetailNewsUseCase _getDetailNewsUseCase;
  CheckLikeNewsForCurrentUserUseCase _checkLikeNewsForCurrentUserUseCase;
  ChangeFollowUseCase _changeFollowUserUseCase;
  ChangeLikeNewsForCurrentUserUseCase _changeLikeNewsForCurrentUserUseCase;
  CountAllCommentByNewsIdUseCase _countAllCommentByNewsIdUseCase;
}