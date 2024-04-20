import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:gunslinger_rush/common/presentation/game_container.dart';
import 'package:gunslinger_rush/common/presentation/router/screens.dart';
import 'package:gunslinger_rush/common/presentation/theme/theme_build_context_extensions.dart';
import 'package:gunslinger_rush/features/pvp/domain/game_start_data.dart';
import 'package:gunslinger_rush/features/pvp/domain/game_state.dart';
import 'package:gunslinger_rush/features/pvp/presentation/game_participant.dart';
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

  @override
  Widget build(BuildContext context) {
    ref.listen(
      gameScreenControllerProvider(widget.gameData)
          .select((value) => value.gameStatus),
      _onGameStatusChange,
    );

    final state = _watchGameState();

    return GestureDetector(
      onTap: () async {
        await _gameController().onPlayerTap();
      },
      child: GameContainer(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 32),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.circleXmark,
                      color: context.colorScheme.error,
                      size: 40,
                    ),
                    onPressed: () async {
                      await _gameController().onLeaveGame();
                      if (context.mounted) {
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: [
                      Positioned(
                        child: GameParticipant(
                          player: widget.gameData.opponent,
                          livesLeft: 3 - state.playerPoints,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GameParticipant(
                          player: widget.gameData.player,
                          livesLeft: 3 - state.opponentPoints,
                        ),
                      ),
                      if (state.isMomentToShoot && !state.shotThisRound)
                        IgnorePointer(
                          child: Align(
                            child: Text(
                              'Shoot!',
                              style: context.textTheme.displayLarge!.copyWith(
                                fontFamily: 'Carnevalee',
                                fontSize: 45,
                              ),
                            ),
                          ),
                        ),
                      if (state.roundWarmup)
                        IgnorePointer(
                          child: Align(
                            child: Text(
                              'Get ready!',
                              style: context.textTheme.displayLarge!.copyWith(
                                fontFamily: 'Carnevalee',
                                fontSize: 45,
                              ),
                            ),
                          ),
                        ),
                      IgnorePointer(
                        child: Align(
                          child: Text(
                            state.roundResultText,
                            style: context.textTheme.displayLarge!.copyWith(
                              fontFamily: 'Carnevalee',
                              fontSize: 35,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
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
                context.pushReplacement(
                  Screens.lobbyScreen,
                  extra: widget.gameData.player,
                );
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
