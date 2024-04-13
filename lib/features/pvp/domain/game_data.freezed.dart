// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$GameData {
  String get gameId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get opponentId => throw _privateConstructorUsedError;
  List<int> get moments => throw _privateConstructorUsedError;
  DateTime get ntpStartTime => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GameDataCopyWith<GameData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameDataCopyWith<$Res> {
  factory $GameDataCopyWith(GameData value, $Res Function(GameData) then) =
      _$GameDataCopyWithImpl<$Res, GameData>;
  @useResult
  $Res call(
      {String gameId,
      String userId,
      String opponentId,
      List<int> moments,
      DateTime ntpStartTime});
}

/// @nodoc
class _$GameDataCopyWithImpl<$Res, $Val extends GameData>
    implements $GameDataCopyWith<$Res> {
  _$GameDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gameId = null,
    Object? userId = null,
    Object? opponentId = null,
    Object? moments = null,
    Object? ntpStartTime = null,
  }) {
    return _then(_value.copyWith(
      gameId: null == gameId
          ? _value.gameId
          : gameId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      opponentId: null == opponentId
          ? _value.opponentId
          : opponentId // ignore: cast_nullable_to_non_nullable
              as String,
      moments: null == moments
          ? _value.moments
          : moments // ignore: cast_nullable_to_non_nullable
              as List<int>,
      ntpStartTime: null == ntpStartTime
          ? _value.ntpStartTime
          : ntpStartTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GameDataImplCopyWith<$Res>
    implements $GameDataCopyWith<$Res> {
  factory _$$GameDataImplCopyWith(
          _$GameDataImpl value, $Res Function(_$GameDataImpl) then) =
      __$$GameDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String gameId,
      String userId,
      String opponentId,
      List<int> moments,
      DateTime ntpStartTime});
}

/// @nodoc
class __$$GameDataImplCopyWithImpl<$Res>
    extends _$GameDataCopyWithImpl<$Res, _$GameDataImpl>
    implements _$$GameDataImplCopyWith<$Res> {
  __$$GameDataImplCopyWithImpl(
      _$GameDataImpl _value, $Res Function(_$GameDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gameId = null,
    Object? userId = null,
    Object? opponentId = null,
    Object? moments = null,
    Object? ntpStartTime = null,
  }) {
    return _then(_$GameDataImpl(
      gameId: null == gameId
          ? _value.gameId
          : gameId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      opponentId: null == opponentId
          ? _value.opponentId
          : opponentId // ignore: cast_nullable_to_non_nullable
              as String,
      moments: null == moments
          ? _value._moments
          : moments // ignore: cast_nullable_to_non_nullable
              as List<int>,
      ntpStartTime: null == ntpStartTime
          ? _value.ntpStartTime
          : ntpStartTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$GameDataImpl extends _GameData {
  const _$GameDataImpl(
      {required this.gameId,
      required this.userId,
      required this.opponentId,
      required final List<int> moments,
      required this.ntpStartTime})
      : _moments = moments,
        super._();

  @override
  final String gameId;
  @override
  final String userId;
  @override
  final String opponentId;
  final List<int> _moments;
  @override
  List<int> get moments {
    if (_moments is EqualUnmodifiableListView) return _moments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_moments);
  }

  @override
  final DateTime ntpStartTime;

  @override
  String toString() {
    return 'GameData(gameId: $gameId, userId: $userId, opponentId: $opponentId, moments: $moments, ntpStartTime: $ntpStartTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameDataImpl &&
            (identical(other.gameId, gameId) || other.gameId == gameId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.opponentId, opponentId) ||
                other.opponentId == opponentId) &&
            const DeepCollectionEquality().equals(other._moments, _moments) &&
            (identical(other.ntpStartTime, ntpStartTime) ||
                other.ntpStartTime == ntpStartTime));
  }

  @override
  int get hashCode => Object.hash(runtimeType, gameId, userId, opponentId,
      const DeepCollectionEquality().hash(_moments), ntpStartTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GameDataImplCopyWith<_$GameDataImpl> get copyWith =>
      __$$GameDataImplCopyWithImpl<_$GameDataImpl>(this, _$identity);
}

abstract class _GameData extends GameData {
  const factory _GameData(
      {required final String gameId,
      required final String userId,
      required final String opponentId,
      required final List<int> moments,
      required final DateTime ntpStartTime}) = _$GameDataImpl;
  const _GameData._() : super._();

  @override
  String get gameId;
  @override
  String get userId;
  @override
  String get opponentId;
  @override
  List<int> get moments;
  @override
  DateTime get ntpStartTime;
  @override
  @JsonKey(ignore: true)
  _$$GameDataImplCopyWith<_$GameDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
