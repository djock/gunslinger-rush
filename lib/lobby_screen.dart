import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gunslinger_rush/game_screen.dart';
import 'package:ntp/ntp.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class LobbyScreen extends StatefulWidget {
  LobbyScreen({Key? key}) : super(key: key);

  @override
  State<LobbyScreen> createState() => _LobbyScreenState();
}

class _LobbyScreenState extends State<LobbyScreen> {
  final supabaseClient = Supabase.instance.client;

  List<String> _userIds = [];
  final myUserId = const Uuid().v4();
  List<int> _randomMoments = [];
  int _gameDuration = 60;

  late final RealtimeChannel _lobbyChannel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(16),
          child: ListView.builder(
            itemCount: _userIds.length + 1,
            itemBuilder: (context, index) {
              if (index == _userIds.length) {
                return Column(
                  children: [
                    SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                      onPressed: _userIds.length < 2
                          ? null
                          : () async {
                              final opponentId = _userIds
                                  .firstWhere((userId) => userId != myUserId);
                              final gameId = const Uuid().v4();

                              _generateRandomMoments();

                              await _lobbyChannel.sendBroadcastMessage(
                                event: 'game_start',
                                payload: {
                                  'participants': [
                                    opponentId,
                                    myUserId,
                                  ],
                                  'game_id': gameId,
                                  'moments': _randomMoments
                                },
                              );
                            },
                      child: Text(
                        _userIds.length < 2
                            ? 'Waiting for other players'
                            : 'Start Game',
                      ),
                    ),
                  ],
                );
              }
              return Text(
                'Player ${index + 1}: ' + _userIds[index].split('-')[0],
                style: TextStyle(fontSize: 18),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _joinLobby();
  }

  void _joinLobby() {
    _lobbyChannel = supabaseClient.channel(
      'lobby',
      opts: const RealtimeChannelConfig(self: true),
    );

    _lobbyChannel
        .onPresenceSync((payload, [ref]) {
          // Update the lobby count
          final presenceStates = _lobbyChannel.presenceState();

          setState(() {
            _userIds = presenceStates
                .map((presenceState) => (presenceState.presences.first)
                    .payload['user_id'] as String)
                .toList();
          });
        })
        .onBroadcast(
            event: 'game_start',
            callback: (payload, [_]) async {
              // Start the game if someone has started a game with you
              final participantIds = List<String>.from(payload['participants']);
              if (participantIds.contains(myUserId)) {
                final gameId = payload['game_id'] as String;
                final moments = List<int>.from(payload['moments']);

                final gameStart = (await NTP.now()).add(Duration(seconds: 7));

                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => GameScreen(
                      gameId: gameId,
                      userId: myUserId,
                      opponentId: participantIds.firstWhere(
                        (id) => id != myUserId,
                      ),
                      moments: moments,
                      NTPStartTime: gameStart,
                    ),
                  ),
                );
              }
            })
        .subscribe(
          (status, _) async {
            if (status == RealtimeSubscribeStatus.subscribed) {
              await _lobbyChannel.track({'user_id': myUserId});
            }
          },
        );
  }

  void _generateRandomMoments() {
    final random = Random();
    _randomMoments = [];

    for (int i = 0; i < 6; i++) {
      _randomMoments.add(random.nextInt(9) + 1);
    }
  }
}
