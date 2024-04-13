// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$GameState {
  int get tick => throw _privateConstructorUsedError;
  bool get isMomentToShoot => throw _privateConstructorUsedError;
  List<String> get shootTimestamps => throw _privateConstructorUsedError;
  bool get shotThisRound => throw _privateConstructorUsedError;
  bool get roundWarmup => throw _privateConstructorUsedError;
  int get playerPoints => throw _privateConstructorUsedError;
  int get opponentPoints => throw _privateConstructorUsedError;
  String get roundResultText => throw _privateConstructorUsedError;
  Map<int, Map<String, int>> get roundTimestamps =>
      throw _privateConstructorUsedError;
  int get currentRoundIndex => throw _privateConstructorUsedError;
  GameStatus get gameStatus => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GameStateCopyWith<GameState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameStateCopyWith<$Res> {
  factory $GameStateCopyWith(GameState value, $Res Function(GameState) then) =
      _$GameStateCopyWithImpl<$Res, GameState>;
  @useResult
  $Res call(
      {int tick,
      bool isMomentToShoot,
      List<String> shootTimestamps,
      bool shotThisRound,
      bool roundWarmup,
      int playerPoints,
      int opponentPoints,
      String roundResultText,
      Map<int, Map<String, int>> roundTimestamps,
      int currentRoundIndex,
      GameStatus gameStatus});
}

/// @nodoc
class _$GameStateCopyWithImpl<$Res, $Val extends GameState>
    implements $GameStateCopyWith<$Res> {
  _$GameStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tick = null,
    Object? isMomentToShoot = null,
    Object? shootTimestamps = null,
    Object? shotThisRound = null,
    Object? roundWarmup = null,
    Object? playerPoints = null,
    Object? opponentPoints = null,
    Object? roundResultText = null,
    Object? roundTimestamps = null,
    Object? currentRoundIndex = null,
    Object? gameStatus = null,
  }) {
    return _then(_value.copyWith(
      tick: null == tick
          ? _value.tick
          : tick // ignore: cast_nullable_to_non_nullable
              as int,
      isMomentToShoot: null == isMomentToShoot
          ? _value.isMomentToShoot
          : isMomentToShoot // ignore: cast_nullable_to_non_nullable
              as bool,
      shootTimestamps: null == shootTimestamps
          ? _value.shootTimestamps
          : shootTimestamps // ignore: cast_nullable_to_non_nullable
              as List<String>,
      shotThisRound: null == shotThisRound
          ? _value.shotThisRound
          : shotThisRound // ignore: cast_nullable_to_non_nullable
              as bool,
      roundWarmup: null == roundWarmup
          ? _value.roundWarmup
          : roundWarmup // ignore: cast_nullable_to_non_nullable
              as bool,
      playerPoints: null == playerPoints
          ? _value.playerPoints
          : playerPoints // ignore: cast_nullable_to_non_nullable
              as int,
      opponentPoints: null == opponentPoints
          ? _value.opponentPoints
          : opponentPoints // ignore: cast_nullable_to_non_nullable
              as int,
      roundResultText: null == roundResultText
          ? _value.roundResultText
          : roundResultText // ignore: cast_nullable_to_non_nullable
              as String,
      roundTimestamps: null == roundTimestamps
          ? _value.roundTimestamps
          : roundTimestamps // ignore: cast_nullable_to_non_nullable
              as Map<int, Map<String, int>>,
      currentRoundIndex: null == currentRoundIndex
          ? _value.currentRoundIndex
          : currentRoundIndex // ignore: cast_nullable_to_non_nullable
              as int,
      gameStatus: null == gameStatus
          ? _value.gameStatus
          : gameStatus // ignore: cast_nullable_to_non_nullable
              as GameStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GameStateImplCopyWith<$Res>
    implements $GameStateCopyWith<$Res> {
  factory _$$GameStateImplCopyWith(
          _$GameStateImpl value, $Res Function(_$GameStateImpl) then) =
      __$$GameStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int tick,
      bool isMomentToShoot,
      List<String> shootTimestamps,
      bool shotThisRound,
      bool roundWarmup,
      int playerPoints,
      int opponentPoints,
      String roundResultText,
      Map<int, Map<String, int>> roundTimestamps,
      int currentRoundIndex,
      GameStatus gameStatus});
}

/// @nodoc
class __$$GameStateImplCopyWithImpl<$Res>
    extends _$GameStateCopyWithImpl<$Res, _$GameStateImpl>
    implements _$$GameStateImplCopyWith<$Res> {
  __$$GameStateImplCopyWithImpl(
      _$GameStateImpl _value, $Res Function(_$GameStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tick = null,
    Object? isMomentToShoot = null,
    Object? shootTimestamps = null,
    Object? shotThisRound = null,
    Object? roundWarmup = null,
    Object? playerPoints = null,
    Object? opponentPoints = null,
    Object? roundResultText = null,
    Object? roundTimestamps = null,
    Object? currentRoundIndex = null,
    Object? gameStatus = null,
  }) {
    return _then(_$GameStateImpl(
      tick: null == tick
          ? _value.tick
          : tick // ignore: cast_nullable_to_non_nullable
              as int,
      isMomentToShoot: null == isMomentToShoot
          ? _value.isMomentToShoot
          : isMomentToShoot // ignore: cast_nullable_to_non_nullable
              as bool,
      shootTimestamps: null == shootTimestamps
          ? _value._shootTimestamps
          : shootTimestamps // ignore: cast_nullable_to_non_nullable
              as List<String>,
      shotThisRound: null == shotThisRound
          ? _value.shotThisRound
          : shotThisRound // ignore: cast_nullable_to_non_nullable
              as bool,
      roundWarmup: null == roundWarmup
          ? _value.roundWarmup
          : roundWarmup // ignore: cast_nullable_to_non_nullable
              as bool,
      playerPoints: null == playerPoints
          ? _value.playerPoints
          : playerPoints // ignore: cast_nullable_to_non_nullable
              as int,
      opponentPoints: null == opponentPoints
          ? _value.opponentPoints
          : opponentPoints // ignore: cast_nullable_to_non_nullable
              as int,
      roundResultText: null == roundResultText
          ? _value.roundResultText
          : roundResultText // ignore: cast_nullable_to_non_nullable
              as String,
      roundTimestamps: null == roundTimestamps
          ? _value._roundTimestamps
          : roundTimestamps // ignore: cast_nullable_to_non_nullable
              as Map<int, Map<String, int>>,
      currentRoundIndex: null == currentRoundIndex
          ? _value.currentRoundIndex
          : currentRoundIndex // ignore: cast_nullable_to_non_nullable
              as int,
      gameStatus: null == gameStatus
          ? _value.gameStatus
          : gameStatus // ignore: cast_nullable_to_non_nullable
              as GameStatus,
    ));
  }
}

/// @nodoc

class _$GameStateImpl extends _GameState {
  const _$GameStateImpl(
      {this.tick = 0,
      this.isMomentToShoot = false,
      final List<String> shootTimestamps = const [],
      this.shotThisRound = false,
      this.roundWarmup = true,
      this.playerPoints = 0,
      this.opponentPoints = 0,
      this.roundResultText = '',
      final Map<int, Map<String, int>> roundTimestamps = const {},
      this.currentRoundIndex = 0,
      this.gameStatus = GameStatus.loading})
      : _shootTimestamps = shootTimestamps,
        _roundTimestamps = roundTimestamps,
        super._();

  @override
  @JsonKey()
  final int tick;
  @override
  @JsonKey()
  final bool isMomentToShoot;
  final List<String> _shootTimestamps;
  @override
  @JsonKey()
  List<String> get shootTimestamps {
    if (_shootTimestamps is EqualUnmodifiableListView) return _shootTimestamps;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_shootTimestamps);
  }

  @override
  @JsonKey()
  final bool shotThisRound;
  @override
  @JsonKey()
  final bool roundWarmup;
  @override
  @JsonKey()
  final int playerPoints;
  @override
  @JsonKey()
  final int opponentPoints;
  @override
  @JsonKey()
  final String roundResultText;
  final Map<int, Map<String, int>> _roundTimestamps;
  @override
  @JsonKey()
  Map<int, Map<String, int>> get roundTimestamps {
    if (_roundTimestamps is EqualUnmodifiableMapView) return _roundTimestamps;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_roundTimestamps);
  }

  @override
  @JsonKey()
  final int currentRoundIndex;
  @override
  @JsonKey()
  final GameStatus gameStatus;

  @override
  String toString() {
    return 'GameState(tick: $tick, isMomentToShoot: $isMomentToShoot, shootTimestamps: $shootTimestamps, shotThisRound: $shotThisRound, roundWarmup: $roundWarmup, playerPoints: $playerPoints, opponentPoints: $opponentPoints, roundResultText: $roundResultText, roundTimestamps: $roundTimestamps, currentRoundIndex: $currentRoundIndex, gameStatus: $gameStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameStateImpl &&
            (identical(other.tick, tick) || other.tick == tick) &&
            (identical(other.isMomentToShoot, isMomentToShoot) ||
                other.isMomentToShoot == isMomentToShoot) &&
            const DeepCollectionEquality()
                .equals(other._shootTimestamps, _shootTimestamps) &&
            (identical(other.shotThisRound, shotThisRound) ||
                other.shotThisRound == shotThisRound) &&
            (identical(other.roundWarmup, roundWarmup) ||
                other.roundWarmup == roundWarmup) &&
            (identical(other.playerPoints, playerPoints) ||
                other.playerPoints == playerPoints) &&
            (identical(other.opponentPoints, opponentPoints) ||
                other.opponentPoints == opponentPoints) &&
            (identical(other.roundResultText, roundResultText) ||
                other.roundResultText == roundResultText) &&
            const DeepCollectionEquality()
                .equals(other._roundTimestamps, _roundTimestamps) &&
            (identical(other.currentRoundIndex, currentRoundIndex) ||
                other.currentRoundIndex == currentRoundIndex) &&
            (identical(other.gameStatus, gameStatus) ||
                other.gameStatus == gameStatus));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      tick,
      isMomentToShoot,
      const DeepCollectionEquality().hash(_shootTimestamps),
      shotThisRound,
      roundWarmup,
      playerPoints,
      opponentPoints,
      roundResultText,
      const DeepCollectionEquality().hash(_roundTimestamps),
      currentRoundIndex,
      gameStatus);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GameStateImplCopyWith<_$GameStateImpl> get copyWith =>
      __$$GameStateImplCopyWithImpl<_$GameStateImpl>(this, _$identity);
}

abstract class _GameState extends GameState {
  const factory _GameState(
      {final int tick,
      final bool isMomentToShoot,
      final List<String> shootTimestamps,
      final bool shotThisRound,
      final bool roundWarmup,
      final int playerPoints,
      final int opponentPoints,
      final String roundResultText,
      final Map<int, Map<String, int>> roundTimestamps,
      final int currentRoundIndex,
      final GameStatus gameStatus}) = _$GameStateImpl;
  const _GameState._() : super._();

  @override
  int get tick;
  @override
  bool get isMomentToShoot;
  @override
  List<String> get shootTimestamps;
  @override
  bool get shotThisRound;
  @override
  bool get roundWarmup;
  @override
  int get playerPoints;
  @override
  int get opponentPoints;
  @override
  String get roundResultText;
  @override
  Map<int, Map<String, int>> get roundTimestamps;
  @override
  int get currentRoundIndex;
  @override
  GameStatus get gameStatus;
  @override
  @JsonKey(ignore: true)
  _$$GameStateImplCopyWith<_$GameStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
