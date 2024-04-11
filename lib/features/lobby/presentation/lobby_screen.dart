import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gunslinger_rush/features/common/domain/player.dart';
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

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: lobbyPlayers.length + 1,
          itemBuilder: (context, index) {
            if (index == lobbyPlayers.length) {
              return Column(
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                    onPressed: lobbyPlayers.length < 2
                        ? null
                        : () async {
                            await ref
                                .read(
                                  lobbyScreenControllerProvider(widget.player)
                                      .notifier,
                                )
                                .startGame(widget.player);
                          },
                    child: Text(
                      lobbyPlayers.length < 2
                          ? 'Waiting for other players'
                          : 'Start Game',
                    ),
                  ),
                ],
              );
            }
            return Text(
              'Player ${index + 1}: ${lobbyPlayers[index].name.split('-')[0]}',
              style: const TextStyle(fontSize: 18),
            );
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
