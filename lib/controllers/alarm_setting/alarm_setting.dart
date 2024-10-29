import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'alarm_setting.freezed.dart';

part 'alarm_setting.g.dart';

@freezed
class AlarmSettingState with _$AlarmSettingState {
  const factory AlarmSettingState({
    @Default('') String inputTime,
    @Default(0) int selectedEditId,
    @Default(true) bool firstMove,
  }) = _AlarmSettingState;
}

@Riverpod(keepAlive: true)
class AlarmSetting extends _$AlarmSetting {
  ///
  @override
  AlarmSettingState build() => const AlarmSettingState();

  ///
  Future<void> setInputTime({required String time}) async =>
      state = state.copyWith(inputTime: time);

  ///
  void setSelectedEditId({required int id}) =>
      state = state.copyWith(selectedEditId: id);

  ///
  void setFirstMove({required bool flag}) =>
      state = state.copyWith(firstMove: flag);
}
