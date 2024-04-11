import 'package:freezed_annotation/freezed_annotation.dart';
part 'game_data.freezed.dart';

@freezed
class GameData with _$GameData {
  const factory GameData({
    required String gameId,
    required String userId,
    required String opponentId,
    required List<int> moments,
    required DateTime ntpStartTime,
  }) = _GameData;
  const GameData._();
}
