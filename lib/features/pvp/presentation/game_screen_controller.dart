import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:gunslinger_rush/common/data_source/supabase_channel_service.dart';
import 'package:gunslinger_rush/common/presentation/router/game_router.dart';
import 'package:gunslinger_rush/features/pvp/domain/game_start_data.dart';
import 'package:gunslinger_rush/features/pvp/domain/game_state.dart';
import 'package:gunslinger_rush/main.dart';
import 'package:ntp/ntp.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'game_screen_controller.g.dart';

@riverpod
class GameScreenController extends _$GameScreenController {
  late final RealtimeChannel _gameChannel;
  Timer? _gameTimer;
  GameStartData? _gameStartData;

  final List<String> _shootTimestamps = [];
  final Map<int, Map<String, int>> _roundTimestamps = {};
  bool _isMomentToShoot = false;
  late Duration _offset;

  @override
  GameState build(GameStartData gameStartData) {
    _gameStartData = gameStartData;

    final currentTime = DateTime.now().toLocal();
    final currentTimeOffset =
        currentTime.add(Duration(milliseconds: ntpOffset));
    _offset = currentTimeOffset.difference(gameStartData.ntpStartTime);

    _createGame(gameStartData.gameId);

    ref.onDispose(() {
      _gameTimer?.cancel();
    });

    Future.delayed(const Duration(seconds: 3), _startRoundTimer);

    return const GameState();
  }

  Future<void> onPlayerTap() async {
    if (state.shotThisRound) {
      return;
    }

    state = state.copyWith(
      shotThisRound: true,
    );

    await _gameChannel.sendBroadcastMessage(
      event: 'game_state-${_gameStartData!.gameId}',
      payload: {
        'player_id': _gameStartData!.player.id,
        'player_name': _gameStartData!.player.name,
        'shoot': (await NTP.now()).millisecondsSinceEpoch +
            (_isMomentToShoot ? 0 : 3600000),
        'round': state.currentRoundIndex,
      },
    );
  }

  Future<void> onLeaveGame() async {
    await _gameChannel.sendBroadcastMessage(
      event: 'game_end-${_gameStartData!.gameId}',
      payload: {
        'player_id': _gameStartData!.player.id,
        'status': 'player_left',
      },
    );
  }

  void _createGame(String gameId) {
    _gameChannel = ref.read(supabaseChannelServiceProvider(gameId));

    _gameChannel
        .onBroadcast(
          event: 'game_state-$gameId',
          callback: (payload, [_]) {
            final playerId = payload['player_id'] as String;
            final playerName = payload['player_name'] as String;
            final shootTimestamp = payload['shoot'] as int;
            final round = payload['round'] as int;
            final shootDateTime =
                DateTime.fromMillisecondsSinceEpoch(shootTimestamp);

            _shootTimestamps
                .add('[$round]${playerName.split('-')[0]} $shootDateTime');

            // Store the timestamp for the current round
            if (!_roundTimestamps.containsKey(round)) {
              _roundTimestamps[round] = {};
            }
            _roundTimestamps[round]![playerId] = shootTimestamp;

            // Check if both players have shot for the current round
            if (_roundTimestamps[round]!.length == 2) {
              // Determine the winner for the current round
              _determineRoundWinner(round);
              _gameTimer!.cancel();
            }

            _isMomentToShoot = false;

            state = state.copyWith(
              shootTimestamps: _shootTimestamps,
              isMomentToShoot: _isMomentToShoot,
              roundTimestamps: _roundTimestamps,
            );
          },
        )
        .onBroadcast(
          event: 'game_end-$gameId',
          callback: (payload, [_]) {
            final playerId = payload['player_id'] as String;
            final gameStatus = payload['status'] as String;

            if (gameStatus == 'game_ended') {
              state = state.copyWith(
                gameStatus: GameStatus.finished,
              );
            }

            if (gameStatus == 'player_left' &&
                playerId == _gameStartData!.opponent.id) {
              state = state.copyWith(
                gameStatus: GameStatus.opponentLeft,
              );
            }

            Future.delayed(const Duration(seconds: 3), () {
              ref.read(gameRouterProvider).pop();
            });
          },
        )
        .subscribe();
  }

  void _startRoundTimer({int dataIndex = 0}) {
    debugPrint('Start round $dataIndex');
    if (dataIndex != 0) {
      state = state.copyWith(
        currentRoundIndex: state.currentRoundIndex + 1,
      );
    }

    Future.delayed(_offset, () async {
      state = state.copyWith(
        roundWarmup: false,
        shotThisRound: false,
      );

      _gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) async {
        if (timer.tick == _gameStartData!.moments[dataIndex]) {
          state = state.copyWith(
            isMomentToShoot: true,
          );
        }
        debugPrint('${timer.tick} VS ${_gameStartData!.moments[dataIndex]}');
      });
    });
  }

  void _determineRoundWinner(int round) {
    if (_gameStartData == null) {
      return;
    }

    final playerTimestamp = _roundTimestamps[round]![_gameStartData!.player.id];
    final opponentTimestamp =
        _roundTimestamps[round]![_gameStartData!.opponent.id];
    var roundResultText = '';

    var isPlayerWin = false;

    if (playerTimestamp != null) {
      if (opponentTimestamp == null) {
        isPlayerWin = true;
      } else {
        isPlayerWin = playerTimestamp < opponentTimestamp;
      }
    }

    var playerPoints = state.playerPoints;
    var opponentPoints = state.opponentPoints;

    if (isPlayerWin) {
      roundResultText = 'You won round ${round + 1}';
      playerPoints++;
    } else {
      roundResultText = 'You lost round ${round + 1}';
      opponentPoints++;
    }

    if (playerPoints == 3 ||
        opponentPoints == 3 ||
        state.currentRoundIndex == 6) {
      state = state.copyWith(
        gameStatus: GameStatus.finished,
      );

      return;
    }

    state = state.copyWith(
      playerPoints: playerPoints,
      opponentPoints: opponentPoints,
      roundResultText: roundResultText,
    );

    Future.delayed(const Duration(seconds: 3), () {
      state = state.copyWith(
        roundResultText: '',
        roundWarmup: true,
      );

      Future.delayed(const Duration(seconds: 3), () {
        _startRoundTimer(dataIndex: state.currentRoundIndex + 1);
      });
    });
  }
}
