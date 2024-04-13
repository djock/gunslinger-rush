import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gunslinger_rush/common/domain/player.dart';
import 'package:gunslinger_rush/common/presentation/animated_button.dart';
import 'package:gunslinger_rush/common/presentation/game_container.dart';
import 'package:gunslinger_rush/common/presentation/slideable_text.dart';
import 'package:gunslinger_rush/common/presentation/theme/theme_build_context_extensions.dart';
import 'package:gunslinger_rush/features/lobby/presentation/lobby_screen_controller.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LobbyScreen extends ConsumerStatefulWidget {
  const LobbyScreen({required this.player, super.key});

  final Player player;

  @override
  ConsumerState<LobbyScreen> createState() => _LobbyScreenState();
}

class _LobbyScreenState extends ConsumerState<LobbyScreen> {
  final supabaseClient = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    final lobbyPlayers =
        ref.watch(lobbyScreenControllerProvider(widget.player)).value ?? [];

    return GameContainer(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 48,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Align(
                            child: Image.asset(
                              'assets/images/saloon_doors.png',
                              color: Colors.brown.withAlpha(400),
                            ),
                          ),
                          Positioned(
                            bottom: 15,
                            left: 0,
                            right: 0,
                            child: Text(
                              'Saloon',
                              textAlign: TextAlign.center,
                              style: context.textTheme.displayLarge!.copyWith(
                                fontFamily: 'Carnevalee',
                                fontSize: 72,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Align(
                  child: Text(
                    'Gunslingers waiting:',
                    textAlign: TextAlign.center,
                    style: context.textTheme.displayLarge!.copyWith(
                      fontFamily: 'Carnevalee',
                      fontSize: 28,
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: lobbyPlayers.length + 1,
                  itemBuilder: (context, index) {
                    if (index == lobbyPlayers.length) {
                      return Column(
                        children: [
                          const SizedBox(
                            height: 16,
                          ),
                          AnimatedButton(
                            onPressed: _onStartGame,
                            isButtonEnabled: lobbyPlayers.length >= 2,
                            child: Text(
                              lobbyPlayers.length < 2
                                  ? 'Waiting for other to join'
                                  : '⌖ Start Game ⌖',
                              style: context.textTheme.titleLarge?.copyWith(
                                fontFamily: 'Carnevalee',
                                fontSize: lobbyPlayers.length < 2 ? 20 : 32,
                                color: lobbyPlayers.length < 2
                                    ? context.colorScheme.primary.withAlpha(350)
                                    : context.colorScheme.primary,
                              ),
                            ),
                          ),
                        ],
                      );
                    }

                    return SlideableText(
                      text: lobbyPlayers[index].name.split('-')[0],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onStartGame() async {
    debugPrint('test');
    await ref
        .read(
          lobbyScreenControllerProvider(widget.player).notifier,
        )
        .startGame(widget.player);
  }
}
