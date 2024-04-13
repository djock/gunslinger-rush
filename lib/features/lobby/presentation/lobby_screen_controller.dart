import 'dart:math';

import 'package:gunslinger_rush/common/data/logger_service.dart';
import 'package:gunslinger_rush/common/data_source/supabase_channel_service.dart';
import 'package:gunslinger_rush/common/domain/player.dart';
import 'package:gunslinger_rush/common/presentation/router/game_router.dart';
import 'package:gunslinger_rush/common/presentation/router/screens.dart';
import 'package:gunslinger_rush/features/pvp/domain/game_start_data.dart';
import 'package:ntp/ntp.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

part 'lobby_screen_controller.g.dart';

@riverpod
class LobbyScreenController extends _$LobbyScreenController {
  List<int> _randomMoments = [];
  late final RealtimeChannel _lobbyChannel;

  @override
  Future<List<Player>> build(Player player) async {
    _lobbyChannel = ref.read(supabaseChannelServiceProvider('lobby'));

    var players = <Player>[];
    _lobbyChannel
        .onPresenceSync((payload, [ref]) {
          // Update the lobby count
          final presenceStates = _lobbyChannel.presenceState();

          players = presenceStates
              .map(
                (presenceState) => Player(
                  id: presenceState.presences.first.payload['player_id']
                      .toString(),
                  name:
                      presenceState.presences.first.payload['name'].toString(),
                ),
              )
              .toList();

          state = AsyncData(players);
        })
        .onBroadcast(
          event: 'game_start',
          callback: (payload, [_]) async {
            final participants = (payload['participants'] as List<dynamic>)
                .map((p) => Player.fromJson(p as Map<String, dynamic>))
                .toList();

            if (participants.contains(player)) {
              final gameId = payload['game_id'] as String;
              final moments = List<int>.from(payload['moments'] as List);

              final gameStart =
                  (await NTP.now()).add(const Duration(seconds: 7));

              ref.read(loggerServiceProvider).i('Game started!');
              final router = ref.read(gameRouterProvider);

              await router.push(
                Screens.pvpGameScreen,
                extra: GameStartData(
                  gameId: gameId,
                  player: player,
                  opponent: participants.firstWhere((p) => p.id != player.id),
                  moments: moments,
                  ntpStartTime: gameStart,
                ),
              );
            }
          },
        )
        .subscribe(
          (status, _) async {
            if (status == RealtimeSubscribeStatus.subscribed) {
              await _lobbyChannel.track({
                'player_id': player.id,
                'name': player.name,
              });
            }
          },
        );

    return players;
  }

  Future<void> startGame(Player player) async {
    final lobbyPlayers = state.value ?? [];

    ref.read(loggerServiceProvider).i('Start Game');

    final opponent =
        lobbyPlayers.firstWhere((lobbyPlayer) => lobbyPlayer.id != player.id);
    final gameId = const Uuid().v4();

    _generateRandomMoments();

    await _lobbyChannel.sendBroadcastMessage(
      event: 'game_start',
      payload: {
        'participants': [
          opponent,
          player,
        ],
        'game_id': gameId,
        'moments': _randomMoments,
      },
    );
  }

  void _generateRandomMoments() {
    final random = Random();
    _randomMoments = [];

    for (var i = 0; i < 6; i++) {
      _randomMoments.add(random.nextInt(9) + 1);
    }
  }
}
