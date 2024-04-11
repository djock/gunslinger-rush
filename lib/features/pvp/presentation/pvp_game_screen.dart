import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gunslinger_rush/main.dart';
import 'package:ntp/ntp.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PvPGameScreen extends StatefulWidget {
  const PvPGameScreen({
    super.key,
    required this.gameId,
    required this.userId,
    required this.opponentId,
    required this.moments,
    required this.ntpStartTime,
  });

  final String gameId;
  final String userId;
  final String opponentId;
  final List<int> moments;
  final DateTime ntpStartTime;

  @override
  State<PvPGameScreen> createState() => _PvPGameScreenState();
}

class _PvPGameScreenState extends State<PvPGameScreen> {
  late Duration _offset;
  final supabaseClient = Supabase.instance.client;
  late final RealtimeChannel _gameChannel;

  bool _isMomentToShoot = false;
  Timer? _gameTimer;
  final List<String> _shootTimestamps = [];
  bool _shotThisRound = false;

  bool _roundWarmup = false;

  int _playerPoints = 0;
  int _opponentPoints = 0;

  String _roundResultText = '';
  Map<int, Map<String, int>> roundTimestamps = {};
  int _currentRoundIndex = 0;

  @override
  void initState() {
    super.initState();
    final currentTime = DateTime.now().toLocal();
    final currentTimeOffset =
        currentTime.add(Duration(milliseconds: ntpOffset));
    _offset = currentTimeOffset.difference(widget.ntpStartTime);

    _createGame();
    _roundWarmup = true;
    Future.delayed(const Duration(seconds: 3), () {
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
    for (final item in widget.moments) {
      debugPrint('Moments $item');
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
              _shootTimestamps
                  .add('[$round]${user.split('-')[0]} $shootDateTime');

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
                const SnackBar(
                  content: Text('Game ended'),
                ),
              );
            }

            if (state == 'user_left' && user == widget.opponentId) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content:
                      Text('Your opponent left, closing the game in 3 seconds'),
                ),
              );
            }

            Future.delayed(const Duration(seconds: 3), () {
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
      if (shootTick != 0) {
        _currentRoundIndex++;
      }
    });

    Future.delayed(_offset, () async {
      setState(() {
        _shotThisRound = false;
        _roundWarmup = false;
      });
      _gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) async {
        debugPrint(
          'Round $_currentRoundIndex Tick ${timer.tick} VS ${widget.moments[shootTick]}',
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
        title: const Text('Game Screen'),
        leading: BackButton(
          onPressed: () async {
            await _gameChannel.sendBroadcastMessage(
              event: 'game_end-${widget.gameId}',
              payload: {
                'user': widget.userId,
                'state': 'user_left',
              },
            );
            if (context.mounted) {
              Navigator.of(context).pop();
            }
          },
        ),
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
                      style: const TextStyle(fontSize: 18),
                    );
                  } else if (index == 1) {
                    return Text(
                      'You: $_playerPoints',
                      style: const TextStyle(fontSize: 18),
                    );
                  } else if (index == 2) {
                    return Text(
                      'Opponent: $_opponentPoints',
                      style: const TextStyle(fontSize: 18),
                    );
                  }
                  return Text(_shootTimestamps[index - 3]);
                },
              ),
            ),
            if (_isMomentToShoot && !_shotThisRound)
              const IgnorePointer(
                child: Align(
                  child: Text(
                    'Shoot!',
                    style: TextStyle(fontSize: 45),
                  ),
                ),
              ),
            if (_roundWarmup)
              const IgnorePointer(
                child: Align(
                  child: Text(
                    'Get ready!',
                    style: TextStyle(fontSize: 45),
                  ),
                ),
              ),
            if (_roundResultText != '')
              IgnorePointer(
                child: Align(
                  child: Text(
                    _roundResultText,
                    style: const TextStyle(fontSize: 35),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _determineRoundWinner(int round) {
    final playerTimestamp = roundTimestamps[round]![widget.userId];
    final opponentTimestamp = roundTimestamps[round]![widget.opponentId];
    var roundResultText = '';

    var isPlayerWin = false;

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

    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _roundResultText = '';
        _roundWarmup = true;
      });

      Future.delayed(const Duration(seconds: 3), () {
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

    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Match Result'),
          content: Text(matchResult),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
