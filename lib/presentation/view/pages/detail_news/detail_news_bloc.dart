import 'package:flutter_clean_architecture/domain/usecases/get_detail_news_use_case.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/news.dart';
import '../../../../shared/common/error_converter.dart';
import '../../../base/base_bloc.dart';
import '../../../base/base_state.dart';
import '../../../base/page_status.dart';

part 'detail_news_bloc.freezed.dart';
part 'detail_news_event.dart';
part 'detail_news_state.dart';

@injectable
class DetailNewsBloc extends BaseBloc<DetailNewsEvent, DetailNewsState> {
  DetailNewsBloc(this._getDetailNewsUseCase) : super(const DetailNewsState()) {
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

          }
        } catch(e,s) {
            handleError(emit, ErrorConverter.convert(e, s));
        }
    });
  }
  final GetDetailNewsUseCase _getDetailNewsUseCase;
}