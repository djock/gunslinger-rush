// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_start_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$GameStartData {
  String get gameId => throw _privateConstructorUsedError;
  Player get player => throw _privateConstructorUsedError;
  Player get opponent => throw _privateConstructorUsedError;
  List<int> get moments => throw _privateConstructorUsedError;
  DateTime get ntpStartTime => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GameStartDataCopyWith<GameStartData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameStartDataCopyWith<$Res> {
  factory $GameStartDataCopyWith(
          GameStartData value, $Res Function(GameStartData) then) =
      _$GameStartDataCopyWithImpl<$Res, GameStartData>;
  @useResult
  $Res call(
      {String gameId,
      Player player,
      Player opponent,
      List<int> moments,
      DateTime ntpStartTime});

  $PlayerCopyWith<$Res> get player;
  $PlayerCopyWith<$Res> get opponent;
}

/// @nodoc
class _$GameStartDataCopyWithImpl<$Res, $Val extends GameStartData>
    implements $GameStartDataCopyWith<$Res> {
  _$GameStartDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gameId = null,
    Object? player = null,
    Object? opponent = null,
    Object? moments = null,
    Object? ntpStartTime = null,
  }) {
    return _then(_value.copyWith(
      gameId: null == gameId
          ? _value.gameId
          : gameId // ignore: cast_nullable_to_non_nullable
              as String,
      player: null == player
          ? _value.player
          : player // ignore: cast_nullable_to_non_nullable
              as Player,
      opponent: null == opponent
          ? _value.opponent
          : opponent // ignore: cast_nullable_to_non_nullable
              as Player,
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

  @override
  @pragma('vm:prefer-inline')
  $PlayerCopyWith<$Res> get player {
    return $PlayerCopyWith<$Res>(_value.player, (value) {
      return _then(_value.copyWith(player: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PlayerCopyWith<$Res> get opponent {
    return $PlayerCopyWith<$Res>(_value.opponent, (value) {
      return _then(_value.copyWith(opponent: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GameStartDataImplCopyWith<$Res>
    implements $GameStartDataCopyWith<$Res> {
  factory _$$GameStartDataImplCopyWith(
          _$GameStartDataImpl value, $Res Function(_$GameStartDataImpl) then) =
      __$$GameStartDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String gameId,
      Player player,
      Player opponent,
      List<int> moments,
      DateTime ntpStartTime});

  @override
  $PlayerCopyWith<$Res> get player;
  @override
  $PlayerCopyWith<$Res> get opponent;
}

/// @nodoc
class __$$GameStartDataImplCopyWithImpl<$Res>
    extends _$GameStartDataCopyWithImpl<$Res, _$GameStartDataImpl>
    implements _$$GameStartDataImplCopyWith<$Res> {
  __$$GameStartDataImplCopyWithImpl(
      _$GameStartDataImpl _value, $Res Function(_$GameStartDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gameId = null,
    Object? player = null,
    Object? opponent = null,
    Object? moments = null,
    Object? ntpStartTime = null,
  }) {
    return _then(_$GameStartDataImpl(
      gameId: null == gameId
          ? _value.gameId
          : gameId // ignore: cast_nullable_to_non_nullable
              as String,
      player: null == player
          ? _value.player
          : player // ignore: cast_nullable_to_non_nullable
              as Player,
      opponent: null == opponent
          ? _value.opponent
          : opponent // ignore: cast_nullable_to_non_nullable
              as Player,
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

class _$GameStartDataImpl extends _GameStartData {
  const _$GameStartDataImpl(
      {required this.gameId,
      required this.player,
      required this.opponent,
      required final List<int> moments,
      required this.ntpStartTime})
      : _moments = moments,
        super._();

  @override
  final String gameId;
  @override
  final Player player;
  @override
  final Player opponent;
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
    return 'GameStartData(gameId: $gameId, player: $player, opponent: $opponent, moments: $moments, ntpStartTime: $ntpStartTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameStartDataImpl &&
            (identical(other.gameId, gameId) || other.gameId == gameId) &&
            (identical(other.player, player) || other.player == player) &&
            (identical(other.opponent, opponent) ||
                other.opponent == opponent) &&
            const DeepCollectionEquality().equals(other._moments, _moments) &&
            (identical(other.ntpStartTime, ntpStartTime) ||
                other.ntpStartTime == ntpStartTime));
  }

  @override
  int get hashCode => Object.hash(runtimeType, gameId, player, opponent,
      const DeepCollectionEquality().hash(_moments), ntpStartTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GameStartDataImplCopyWith<_$GameStartDataImpl> get copyWith =>
      __$$GameStartDataImplCopyWithImpl<_$GameStartDataImpl>(this, _$identity);
}

abstract class _GameStartData extends GameStartData {
  const factory _GameStartData(
      {required final String gameId,
      required final Player player,
      required final Player opponent,
      required final List<int> moments,
      required final DateTime ntpStartTime}) = _$GameStartDataImpl;
  const _GameStartData._() : super._();

  @override
  String get gameId;
  @override
  Player get player;
  @override
  Player get opponent;
  @override
  List<int> get moments;
  @override
  DateTime get ntpStartTime;
  @override
  @JsonKey(ignore: true)
  _$$GameStartDataImplCopyWith<_$GameStartDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
