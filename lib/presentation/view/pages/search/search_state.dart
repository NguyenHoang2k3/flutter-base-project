part of 'search_bloc.dart';

@freezed
class SearchState extends BaseState with _$SearchState {

  const SearchState._({required super.pageStatus, required super.pageErrorMessage});

  const factory SearchState({@Default(PageStatus.Loaded) PageStatus pageStatus,
  String? pageErrorMessage,}) = _SearchState;
}