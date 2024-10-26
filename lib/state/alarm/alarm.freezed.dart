// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'alarm.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AlarmState {
  String get inputTime => throw _privateConstructorUsedError;
  int get selectedEditId => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AlarmStateCopyWith<AlarmState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AlarmStateCopyWith<$Res> {
  factory $AlarmStateCopyWith(
          AlarmState value, $Res Function(AlarmState) then) =
      _$AlarmStateCopyWithImpl<$Res, AlarmState>;
  @useResult
  $Res call({String inputTime, int selectedEditId});
}

/// @nodoc
class _$AlarmStateCopyWithImpl<$Res, $Val extends AlarmState>
    implements $AlarmStateCopyWith<$Res> {
  _$AlarmStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inputTime = null,
    Object? selectedEditId = null,
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AlarmStateImplCopyWith<$Res>
    implements $AlarmStateCopyWith<$Res> {
  factory _$$AlarmStateImplCopyWith(
          _$AlarmStateImpl value, $Res Function(_$AlarmStateImpl) then) =
      __$$AlarmStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String inputTime, int selectedEditId});
}

/// @nodoc
class __$$AlarmStateImplCopyWithImpl<$Res>
    extends _$AlarmStateCopyWithImpl<$Res, _$AlarmStateImpl>
    implements _$$AlarmStateImplCopyWith<$Res> {
  __$$AlarmStateImplCopyWithImpl(
      _$AlarmStateImpl _value, $Res Function(_$AlarmStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inputTime = null,
    Object? selectedEditId = null,
  }) {
    return _then(_$AlarmStateImpl(
      inputTime: null == inputTime
          ? _value.inputTime
          : inputTime // ignore: cast_nullable_to_non_nullable
              as String,
      selectedEditId: null == selectedEditId
          ? _value.selectedEditId
          : selectedEditId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$AlarmStateImpl implements _AlarmState {
  const _$AlarmStateImpl({this.inputTime = '', this.selectedEditId = 0});

  @override
  @JsonKey()
  final String inputTime;
  @override
  @JsonKey()
  final int selectedEditId;

  @override
  String toString() {
    return 'AlarmState(inputTime: $inputTime, selectedEditId: $selectedEditId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AlarmStateImpl &&
            (identical(other.inputTime, inputTime) ||
                other.inputTime == inputTime) &&
            (identical(other.selectedEditId, selectedEditId) ||
                other.selectedEditId == selectedEditId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, inputTime, selectedEditId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AlarmStateImplCopyWith<_$AlarmStateImpl> get copyWith =>
      __$$AlarmStateImplCopyWithImpl<_$AlarmStateImpl>(this, _$identity);
}

abstract class _AlarmState implements AlarmState {
  const factory _AlarmState(
      {final String inputTime, final int selectedEditId}) = _$AlarmStateImpl;

  @override
  String get inputTime;
  @override
  int get selectedEditId;
  @override
  @JsonKey(ignore: true)
  _$$AlarmStateImplCopyWith<_$AlarmStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
