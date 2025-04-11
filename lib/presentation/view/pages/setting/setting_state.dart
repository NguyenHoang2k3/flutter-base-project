part of 'setting_bloc.dart';

@freezed
class SettingState extends BaseState with _$SettingState {
  const SettingState( {
    super.pageStatus = PageStatus.Loaded,
    super.pageErrorMessage,
    this.themeMode = ThemeMode.light,
  });
  final ThemeMode themeMode;
}