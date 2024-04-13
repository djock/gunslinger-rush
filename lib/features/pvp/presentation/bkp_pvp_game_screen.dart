import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gunslinger_rush/features/pvp/domain/game_start_data.dart';
import 'package:gunslinger_rush/features/pvp/domain/game_state.dart';
import 'package:gunslinger_rush/features/pvp/presentation/game_screen_controller.dart';

class PvPGameScreen extends ConsumerStatefulWidget {
  const PvPGameScreen({
    super.key,
    required this.gameData,
  });

  final GameStartData gameData;

  @override
  ConsumerState<PvPGameScreen> createState() => _PvPGameScreenState();
}

class _PvPGameScreenState extends ConsumerState<PvPGameScreen> {
  GameScreenController _gameController() {
    return ref.watch(gameScreenControllerProvider(widget.gameData).notifier);
  }

  GameState _gameState() {
    return ref.read(
      gameScreenControllerProvider(widget.gameData),
    );
  }

  GameState _watchGameState() {
    return ref.watch(
      gameScreenControllerProvider(widget.gameData),
    );
  }

  bool _gameStarted = false;

  @override
  Widget build(BuildContext context) {
    ref.listen(
      gameScreenControllerProvider(widget.gameData)
          .select((value) => value.gameStatus),
      _onGameStatusChange,
    );

    final state = _watchGameState();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Screen'),
        leading: BackButton(
          onPressed: () async {
            await _gameController().onLeaveGame();
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
                await _gameController().onPlayerTap();
              },
              child: ListView.builder(
                itemCount: state.shootTimestamps.length + 3,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Text(
                      'Round: ${state.currentRoundIndex + 1}',
                      style: const TextStyle(fontSize: 18),
                    );
                  } else if (index == 1) {
                    return Text(
                      'You: ${state.playerPoints}',
                      style: const TextStyle(fontSize: 18),
                    );
                  } else if (index == 2) {
                    return Text(
                      'Opponent: ${state.opponentPoints}',
                      style: const TextStyle(fontSize: 18),
                    );
                  }
                  return Text(state.shootTimestamps[index - 3]);
                },
              ),
            ),
            if (state.isMomentToShoot && !state.shotThisRound)
              const IgnorePointer(
                child: Align(
                  child: Text(
                    'Shoot!',
                    style: TextStyle(fontSize: 45),
                  ),
                ),
              ),
            if (state.roundWarmup)
              const IgnorePointer(
                child: Align(
                  child: Text(
                    'Get ready!',
                    style: TextStyle(fontSize: 45),
                  ),
                ),
              ),
            if (state.roundResultText != '')
              IgnorePointer(
                child: Align(
                  child: Text(
                    state.roundResultText,
                    style: const TextStyle(fontSize: 35),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _onGameStatusChange(
    GameStatus? previous,
    GameStatus next,
  ) async {
    final state = _gameState();
    String matchResult;
    if (state.playerPoints > state.opponentPoints) {
      matchResult = 'You won the match!';
    } else {
      matchResult = 'You lost the match.';
    }

    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Match Result'),
          content: Text(matchResult),
          actions: [
            TextButton(
              onPressed: () {
                context
                  ..pop()
                  ..pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
