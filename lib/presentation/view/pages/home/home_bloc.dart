import 'package:flutter/foundation.dart';
import 'package:flutter_clean_architecture/domain/entities/news.dart';
import 'package:flutter_clean_architecture/domain/entities/task.dart';
import 'package:flutter_clean_architecture/domain/usecases/get_news_list_use_case.dart';
import 'package:flutter_clean_architecture/shared/utils/logger.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../base/base_bloc.dart';
import '../../../base/base_state.dart';
import '../../../base/page_status.dart';

part 'home_bloc.freezed.dart';

part 'home_event.dart';

part 'home_state.dart';

@injectable
class HomeBloc extends BaseBloc<HomeEvent, HomeState> {
  HomeBloc(this._getNewsListUseCase) : super(const HomeState()) {
    on<HomeEvent>((event, emit) async {
      try {
        if (event == _LoadData()) {
          emit(state.copyWith(pageStatus: PageStatus.Uninitialized));

          final news = await _getNewsListUseCase.call(
            params: GetNewsListParam(),
          );
          emit(state.copyWith(pageStatus: PageStatus.Loaded, newsList: news));
        }
      } catch (e, s) {
        logger.e("Hello ${e}", stackTrace: s);
        //handleError(emit, ErrorConverter.convert(e, s));
      }
    });
  }

  final GetNewsListUseCase _getNewsListUseCase;
}
