import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'alarm.freezed.dart';

part 'alarm.g.dart';

@freezed
class AlarmState with _$AlarmState {
  const factory AlarmState({
    @Default('') String inputTime,
    @Default(0) int selectedEditId,
  }) = _AlarmState;
}

@riverpod
class Alarm extends _$Alarm {
  ///
  @override
  AlarmState build() => const AlarmState();

  ///
  Future<void> setInputTime({required String time}) async =>
      state = state.copyWith(inputTime: time);

  ///
  void setSelectedEditId({required int id}) =>
      state = state.copyWith(selectedEditId: id);
}
