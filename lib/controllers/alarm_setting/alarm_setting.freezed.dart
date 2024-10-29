// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'alarm_setting.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AlarmSettingState {
  String get inputTime => throw _privateConstructorUsedError;
  int get selectedEditId => throw _privateConstructorUsedError;
  bool get firstMove => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AlarmSettingStateCopyWith<AlarmSettingState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AlarmSettingStateCopyWith<$Res> {
  factory $AlarmSettingStateCopyWith(
          AlarmSettingState value, $Res Function(AlarmSettingState) then) =
      _$AlarmSettingStateCopyWithImpl<$Res, AlarmSettingState>;
  @useResult
  $Res call({String inputTime, int selectedEditId, bool firstMove});
}

/// @nodoc
class _$AlarmSettingStateCopyWithImpl<$Res, $Val extends AlarmSettingState>
    implements $AlarmSettingStateCopyWith<$Res> {
  _$AlarmSettingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inputTime = null,
    Object? selectedEditId = null,
    Object? firstMove = null,
  }) {
    return _then(_value.copyWith(
      inputTime: null == inputTime
          ? _value.inputTime
          : inputTime // ignore: cast_nullable_to_non_nullable
              as String,
      selectedEditId: null == selectedEditId
          ? _value.selectedEditId
          : selectedEditId // ignore: cast_nullable_to_non_nullable
              as int,
      firstMove: null == firstMove
          ? _value.firstMove
          : firstMove // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AlarmSettingStateImplCopyWith<$Res>
    implements $AlarmSettingStateCopyWith<$Res> {
  factory _$$AlarmSettingStateImplCopyWith(_$AlarmSettingStateImpl value,
          $Res Function(_$AlarmSettingStateImpl) then) =
      __$$AlarmSettingStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String inputTime, int selectedEditId, bool firstMove});
}

/// @nodoc
class __$$AlarmSettingStateImplCopyWithImpl<$Res>
    extends _$AlarmSettingStateCopyWithImpl<$Res, _$AlarmSettingStateImpl>
    implements _$$AlarmSettingStateImplCopyWith<$Res> {
  __$$AlarmSettingStateImplCopyWithImpl(_$AlarmSettingStateImpl _value,
      $Res Function(_$AlarmSettingStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inputTime = null,
    Object? selectedEditId = null,
    Object? firstMove = null,
  }) {
    return _then(_$AlarmSettingStateImpl(
      inputTime: null == inputTime
          ? _value.inputTime
          : inputTime // ignore: cast_nullable_to_non_nullable
              as String,
      selectedEditId: null == selectedEditId
          ? _value.selectedEditId
          : selectedEditId // ignore: cast_nullable_to_non_nullable
              as int,
      firstMove: null == firstMove
          ? _value.firstMove
          : firstMove // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$AlarmSettingStateImpl implements _AlarmSettingState {
  const _$AlarmSettingStateImpl(
      {this.inputTime = '', this.selectedEditId = 0, this.firstMove = true});

  @override
  @JsonKey()
  final String inputTime;
  @override
  @JsonKey()
  final int selectedEditId;
  @override
  @JsonKey()
  final bool firstMove;

  @override
  String toString() {
    return 'AlarmSettingState(inputTime: $inputTime, selectedEditId: $selectedEditId, firstMove: $firstMove)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AlarmSettingStateImpl &&
            (identical(other.inputTime, inputTime) ||
                other.inputTime == inputTime) &&
            (identical(other.selectedEditId, selectedEditId) ||
                other.selectedEditId == selectedEditId) &&
            (identical(other.firstMove, firstMove) ||
                other.firstMove == firstMove));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, inputTime, selectedEditId, firstMove);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AlarmSettingStateImplCopyWith<_$AlarmSettingStateImpl> get copyWith =>
      __$$AlarmSettingStateImplCopyWithImpl<_$AlarmSettingStateImpl>(
          this, _$identity);
}

abstract class _AlarmSettingState implements AlarmSettingState {
  const factory _AlarmSettingState(
      {final String inputTime,
      final int selectedEditId,
      final bool firstMove}) = _$AlarmSettingStateImpl;

  @override
  String get inputTime;
  @override
  int get selectedEditId;
  @override
  bool get firstMove;
  @override
  @JsonKey(ignore: true)
  _$$AlarmSettingStateImplCopyWith<_$AlarmSettingStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
