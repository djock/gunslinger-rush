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
  late Duration _offset;
  final supabaseClient = Supabase.instance.client;
  late final RealtimeChannel _gameChannel;

  bool _isMomentToShoot = false;
  Timer? _gameTimer;
  List<String> _shootTimestamps = [];
  bool _shotThisRound = false;

  bool _roundStarted = false;
  bool _roundWarmup = false;

  int _playerPoints = 0;
  int _opponentPoints = 0;

  bool _showRoundFinish = false;
  String _roundResultText = '';
  Map<int, Map<String, int>> roundTimestamps = {};
  int _currentRoundIndex = 0;

  @override
  void initState() {
    super.initState();
    var currentTime = DateTime.now().toLocal();
    var currentTimeOffset = currentTime.add(Duration(milliseconds: ntpOffset));
    _offset = currentTimeOffset.difference(widget.NTPStartTime);

    _createGame();
    _roundWarmup = true;
    Future.delayed(Duration(seconds: 3), () {
      _startRoundTimer(shootTick: _currentRoundIndex);
    });
  }

  @override
  void dispose() {
    _gameChannel.unsubscribe();
    _gameTimer?.cancel();
    super.dispose();
  }

  void _createGame() {
    for (var item in widget.moments) {
      debugPrint('Moments ' + item.toString());
    }

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
                _gameTimer!.cancel();
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

  void _startRoundTimer({int shootTick = 0}) {
    setState(() {
      _roundStarted = true;
      if (shootTick != 0) {
        _currentRoundIndex++;
      }
    });

    Future.delayed(_offset, () async {
      setState(() {
        _shotThisRound = false;
        _roundWarmup = false;
      });
      _gameTimer = Timer.periodic(Duration(seconds: 1), (timer) async {
        debugPrint(
          'Round ${_currentRoundIndex} Tick ${timer.tick} VS ${widget.moments[shootTick]}',
        );

        if (timer.tick == widget.moments[shootTick]) {
          setState(() {
            _isMomentToShoot = true;
          });
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
                          (_isMomentToShoot ? 0 : 3600000),
                      'round': _currentRoundIndex,
                    },
                  );
                },
                child: ListView.builder(
                    itemCount: _shootTimestamps.length + 3,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Text(
                          'Round: ${_currentRoundIndex + 1}',
                          style: TextStyle(fontSize: 18),
                        );
                      } else if (index == 1) {
                        return Text(
                          'You: ${_playerPoints}',
                          style: TextStyle(fontSize: 18),
                        );
                      } else if (index == 2) {
                        return Text(
                          'Opponent: ${_opponentPoints}',
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
            if (_roundWarmup)
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
                    style: TextStyle(fontSize: 35),
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

    bool isPlayerWin = false;

    if (playerTimestamp != null) {
      if (opponentTimestamp == null) {
        isPlayerWin = true;
      } else {
        isPlayerWin = playerTimestamp < opponentTimestamp;
      }
    }

    if (isPlayerWin) {
      roundResultText = 'You won round ${round + 1}';
      _playerPoints++;
    } else {
      roundResultText = 'You lost round ${round + 1}';
      _opponentPoints++;
    }

    if (_playerPoints == 3 || _opponentPoints == 3 || _currentRoundIndex == 6) {
      _showMatchResult();
      return;
    }

    setState(() {
      _roundResultText = roundResultText;
    });

    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _roundResultText = '';
        _roundWarmup = true;
      });

      Future.delayed(Duration(seconds: 3), () {
        _startRoundTimer(shootTick: _currentRoundIndex + 1);
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
