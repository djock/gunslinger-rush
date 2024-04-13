import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_state.freezed.dart';

enum GameStatus {
  loading,
  finished,
  opponentLeft,
}

@freezed
class GameState with _$GameState {
  const factory GameState({
    @Default(0) int tick,
    @Default(false) bool isMomentToShoot,
    @Default([]) List<String> shootTimestamps,
    @Default(false) bool shotThisRound,
    @Default(true) bool roundWarmup,
    @Default(0) int playerPoints,
    @Default(0) int opponentPoints,
    @Default('') String roundResultText,
    @Default({}) Map<int, Map<String, int>> roundTimestamps,
    @Default(0) int currentRoundIndex,
    @Default(GameStatus.loading) GameStatus gameStatus,
  }) = _GameState;
  const GameState._();
}
