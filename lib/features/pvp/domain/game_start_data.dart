import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gunslinger_rush/common/domain/player.dart';
part 'game_start_data.freezed.dart';

@freezed
class GameStartData with _$GameStartData {
  const factory GameStartData({
    required String gameId,
    required Player player,
    required Player opponent,
    required List<int> moments,
    required DateTime ntpStartTime,
  }) = _GameStartData;
  const GameStartData._();
}
