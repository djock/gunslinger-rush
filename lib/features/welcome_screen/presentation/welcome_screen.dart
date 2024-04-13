import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gunslinger_rush/common/data/random_list_element_service.dart';
import 'package:gunslinger_rush/common/domain/player.dart';
import 'package:gunslinger_rush/common/presentation/animated_button.dart';
import 'package:gunslinger_rush/common/presentation/game_container.dart';
import 'package:gunslinger_rush/common/presentation/router/game_router.dart';
import 'package:gunslinger_rush/common/presentation/router/screens.dart';
import 'package:gunslinger_rush/common/presentation/theme/theme_build_context_extensions.dart';
import 'package:gunslinger_rush/features/welcome_screen/application/welcome_screen_service.dart';

class WelcomeScreen extends ConsumerStatefulWidget {
  const WelcomeScreen({super.key});

  @override
  WelcomeScreenState createState() => WelcomeScreenState();
}

class WelcomeScreenState extends ConsumerState<WelcomeScreen> {
  final TextEditingController _usernameController = TextEditingController();
  bool _isButtonEnabled = false;

  final List<String> _rewards = [
    '1 bitcoin',
    '1 bowl of soup',
    '1 Big Mac',
    '1 Slap',
    '1 cup of coffee',
    r'$1.000',
    r'$2',
  ];

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GameContainer(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'MOST WANTED',
                textAlign: TextAlign.center,
                style: context.textTheme.displayLarge!
                    .copyWith(fontFamily: 'Carnevalee', fontSize: 90),
              ),
              ref.watch(welcomeScreenServiceProvider).when(
                    data: (player) {
                      if (player == null) {
                        return Column(
                          children: [
                            TextField(
                              controller: _usernameController,
                              onChanged: _onUsernameChanged,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white.withAlpha(50),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(
                                    color: context.colorScheme.primary
                                        .withAlpha(500),
                                    width: 0.5,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(
                                    color: context.colorScheme.primary,
                                    width: 2,
                                  ),
                                ),
                                hintText: 'Your outlaw name',
                                hintStyle: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            AnimatedButton(
                              onPressed: _onSetUsernamePressed,
                              isButtonEnabled: _isButtonEnabled,
                              child: Text(
                                'Enter Town',
                                style: context.textTheme.titleLarge?.copyWith(
                                  fontFamily: 'Carnevalee',
                                  fontSize: 32,
                                  color: _isButtonEnabled
                                      ? context.colorScheme.primary
                                      : context.colorScheme.primary
                                          .withAlpha(350),
                                ),
                              ),
                            ),
                          ],
                        );
                      }

                      Future.delayed(
                        const Duration(seconds: 2),
                        () => _openLobbyScreen(player),
                      );

                      return Text(
                        player.name,
                        textAlign: TextAlign.center,
                        style: context.textTheme.displayLarge!.copyWith(
                          fontFamily: 'Carnevalee',
                          fontSize: 72,
                        ),
                      );
                    },
                    error: (error, stackTrace) => Text(error.toString()),
                    loading: () => const Text('...'),
                  ),
              Column(
                children: [
                  Text(
                    ref.read(getRandomElementFromListProvider(_rewards)),
                    textAlign: TextAlign.center,
                    style: context.textTheme.displayLarge!.copyWith(
                      fontFamily: 'Carnevalee',
                      fontSize: 60,
                      color: context.colorScheme.error,
                    ),
                  ),
                  Text(
                    'REWARD',
                    textAlign: TextAlign.center,
                    style: context.textTheme.displayLarge!.copyWith(
                      fontFamily: 'Carnevalee',
                      fontSize: 72,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onUsernameChanged(String value) {
    setState(() {
      _isButtonEnabled = value.length >= 3;
    });
  }

  Future<void> _onSetUsernamePressed() async {
    final player =
        await ref.read(welcomeScreenServiceProvider.notifier).savePlayer(
              _usernameController.text,
            );

    _openLobbyScreen(player);
  }

  void _openLobbyScreen(Player player) {
    ref
        .read(gameRouterProvider)
        .pushReplacement(Screens.lobbyScreen, extra: player);
  }
}
