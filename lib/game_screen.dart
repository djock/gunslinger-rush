import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gunslinger_rush/main.dart';
import 'package:ntp/ntp.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GameScreen extends StatefulWidget {
  GameScreen({
    Key? key,
    required this.gameId,
    required this.userId,
    required this.opponentId,
    required this.moments,
    required this.NTPStartTime,
  }) : super(key: key);

  final String gameId;
  final String userId;
  final String opponentId;
  final List<int> moments;
  final DateTime NTPStartTime;

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final supabaseClient = Supabase.instance.client;
  late final RealtimeChannel _gameChannel;

  bool _isMomentToShoot = false;
  Timer? _gameTimer;
  List<String> _shootTimestamps = [];
  int _currentRoundIndex = 1;
  bool _shotThisRound = false;

  bool _gameStarted = false;

  int _playerPoints = 0;
  int _opponentPoints = 0;

  bool _showRoundFinish = false;
  String _roundResultText = '';

  Map<int, Map<String, int>> roundTimestamps = {};

  @override
  void initState() {
    super.initState();
    _createGame();
    _startTimer();
  }

  @override
  void dispose() {
    _gameChannel.unsubscribe();
    _gameTimer?.cancel();
    super.dispose();
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
            final round = payload['round'] as int;
            final shootDateTime =
                DateTime.fromMillisecondsSinceEpoch(shootTimestamp);

            setState(() {
              _shootTimestamps.add('[$round]' +
                  user.split('-')[0] +
                  ' ' +
                  shootDateTime.toString());

              // Store the timestamp for the current round
              if (!roundTimestamps.containsKey(round)) {
                roundTimestamps[round] = {};
              }
              roundTimestamps[round]![user] = shootTimestamp;

              // Check if both players have shot for the current round
              if (roundTimestamps[round]!.length == 2) {
                // Determine the winner for the current round
                _determineRoundWinner(round);
              }

              _isMomentToShoot = false;
            });
          },
        )
        .onBroadcast(
          event: 'game_end-${widget.gameId}',
          callback: (payload, [_]) {
            final user = payload['user'] as String;
            final state = payload['state'] as String;

            if (state == 'game_ended') {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Game ended'),
                ),
              );
            }

            if (state == 'user_left' && user == widget.opponentId) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content:
                      Text('Your opponent left, closing the game in 3 seconds'),
                ),
              );
            }

            Future.delayed(Duration(seconds: 3), () {
              if (mounted) {
                Navigator.of(context).pop();
              }
            });
          },
        )
        .subscribe();
  }

  void _startTimer() {
    for (var item in widget.moments) {
      debugPrint('Shoot time ' + item.toString());
    }

    var currentTime = DateTime.now().toLocal();
    var currentTimeOffset = currentTime.add(Duration(milliseconds: ntpOffset));

    var difference = currentTimeOffset.difference(widget.NTPStartTime);

    Future.delayed(difference + Duration(seconds: 3), () async {
      debugPrint('Game started');
      setState(() {
        _gameStarted = true;
      });

      _gameTimer = Timer.periodic(Duration(seconds: 1), (timer) async {
        debugPrint('Tick ${timer.tick}');
        if (widget.moments.contains(timer.tick)) {
          setState(() {
            _isMomentToShoot = true;
          });
        }

        if (timer.tick == 35) {
          await _gameChannel.sendBroadcastMessage(
            event: 'game_end-${widget.gameId}',
            payload: {
              'user': widget.userId,
              'state': 'game_ended',
            },
          );
          Navigator.of(context).pop();
        }
      });
    });
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
        child: Stack(
          children: [
            GestureDetector(
                onTap: () async {
                  if (_shotThisRound) {
                    return;
                  }

                  _shotThisRound = true;
                  await _gameChannel.sendBroadcastMessage(
                    event: 'game_state-${widget.gameId}',
                    payload: {
                      'user': widget.userId,
                      'shoot': (await NTP.now()).millisecondsSinceEpoch +
                          (_isMomentToShoot ? 0 : 3600),
                      'round': _currentRoundIndex,
                    },
                  );
                },
                child: ListView.builder(
                    itemCount: _shootTimestamps.length + 3,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Text(
                          'Round: $_currentRoundIndex',
                          style: TextStyle(fontSize: 18),
                        );
                      } else if (index == 1) {
                        return Text(
                          'You: ${_playerPoints}',
                          style: TextStyle(fontSize: 18),
                        );
                      } else if (index == 2) {
                        return Text(
                          'Opponent: ${_playerPoints}',
                          style: TextStyle(fontSize: 18),
                        );
                      }
                      return Text(_shootTimestamps[index - 3]);
                    })),
            if (_isMomentToShoot && !_shotThisRound)
              IgnorePointer(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Shoot!',
                    style: TextStyle(fontSize: 45),
                  ),
                ),
              ),
            if (!_gameStarted)
              IgnorePointer(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Get ready!',
                    style: TextStyle(fontSize: 45),
                  ),
                ),
              ),
            if (_roundResultText != '')
              IgnorePointer(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    _roundResultText,
                    style: TextStyle(fontSize: 45),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }

  void _determineRoundWinner(int round) {
    final playerTimestamp = roundTimestamps[round]![widget.userId];
    final opponentTimestamp = roundTimestamps[round]![widget.opponentId];
    var roundResultText = '';

    if (playerTimestamp! < opponentTimestamp!) {
      debugPrint('Player won round $round');
      roundResultText = 'You won round $round';
      _playerPoints++;
    } else {
      debugPrint('Opponent won round $round');
      roundResultText = 'You lost round $round';
      _opponentPoints++;
    }

    setState(() {
      _roundResultText = roundResultText;

      _currentRoundIndex++;
      _shotThisRound = false;

      Future.delayed(Duration(seconds: 3), () {
        setState(() {
          _roundResultText = '';
        });

        if (_currentRoundIndex == 3) {
          _showMatchResult();
        }
      });
    });
  }

  void _showMatchResult() {
    String matchResult;
    if (_playerPoints > _opponentPoints) {
      matchResult = 'You won the match!';
    } else {
      matchResult = 'You lost the match.';
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text('Match Result'),
          content: Text(matchResult),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
