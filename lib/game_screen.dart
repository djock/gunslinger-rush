import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GameScreen extends StatefulWidget {
  GameScreen({
    Key? key,
    required this.gameId,
    required this.userId,
    required this.opponentId,
    required this.moments,
  }) : super(key: key);

  final String gameId;
  final String userId;
  final String opponentId;
  final List<int> moments;

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final supabaseClient = Supabase.instance.client;
  late final RealtimeChannel _gameChannel;

  List<String> _shootTimestamps = [];

  @override
  void initState() {
    super.initState();
    _createGame();
  }

  void _createGame() {
    _gameChannel = supabaseClient.channel(
      widget.gameId,
      opts: const RealtimeChannelConfig(self: true),
    );

    _gameChannel
        .onBroadcast(
          event: 'game_state-${widget.gameId}',
          callback: (payload, [_]) {
            final user = payload['user'] as String;
            final shootTimestamp = payload['shoot'] as int;
            final shootDateTime =
                DateTime.fromMillisecondsSinceEpoch(shootTimestamp);

            setState(() {
              _shootTimestamps
                  .add(user.split('-')[0] + ' ' + shootDateTime.toString());
            });
          },
        )
        .onBroadcast(
          event: 'game_end-${widget.gameId}',
          callback: (payload, [_]) {
            final user = payload['user'] as String;

            if (user == widget.opponentId) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content:
                      Text('Your opponent left, closing the game in 3 seconds'),
                ),
              );
            }

            Future.delayed(Duration(seconds: 3), () {
              Navigator.of(context).pop();
            });
          },
        )
        .subscribe();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Game Screen'),
        leading: BackButton(onPressed: () async {
          await _gameChannel.sendBroadcastMessage(
            event: 'game_end-${widget.gameId}',
            payload: {
              'user': widget.userId,
              'state': 'user_left',
            },
          );
          Navigator.of(context).pop();
        }),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GestureDetector(
            onTap: () async {
              await _gameChannel.sendBroadcastMessage(
                event: 'game_state-${widget.gameId}',
                payload: {
                  'user': widget.userId,
                  'shoot': DateTime.now().millisecondsSinceEpoch
                },
              );
            },
            child: ListView.builder(
                itemCount: _shootTimestamps.length,
                itemBuilder: (context, index) {
                  return Text(_shootTimestamps[index]);
                })),
      ),
    );
  }
}
