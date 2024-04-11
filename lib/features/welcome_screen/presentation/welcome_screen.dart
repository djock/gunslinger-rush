import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gunslinger_rush/features/common/presentation/animated_button.dart';
import 'package:gunslinger_rush/features/common/presentation/theme/theme_build_context_extensions.dart';
import 'package:gunslinger_rush/features/lobby/presentation/lobby_screen.dart';
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
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/grunge-paper-background.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
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
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(fontFamily: 'Carnevalee', fontSize: 90),
                ),
                ref.watch(welcomeScreenServiceProvider).when(
                      data: (user) {
                        if (user == null) {
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
                                  hintText: 'Enter your outlaw name',
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
                                  '⌖ Start Game ⌖',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                        fontFamily: 'Carnevalee',
                                        fontSize: 32,
                                        color: _isButtonEnabled
                                            ? Theme.of(context)
                                                .colorScheme
                                                .primary
                                            : Theme.of(context)
                                                .colorScheme
                                                .primary
                                                .withAlpha(350),
                                      ),
                                ),
                              ),
                            ],
                          );
                        }

                        Future.delayed(
                          const Duration(seconds: 2),
                          _openLobbyScreen,
                        );

                        return Text(
                          user.name,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(
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
                      _getRandomRewardText(),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                            fontFamily: 'Carnevalee',
                            fontSize: 60,
                            color: Theme.of(context).colorScheme.error,
                          ),
                    ),
                    Text(
                      'REWARD',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
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
      ),
    );
  }

  void _onUsernameChanged(String value) {
    setState(() {
      _isButtonEnabled = value.length >= 3;
    });
  }

  void _onSetUsernamePressed() {
    ref.read(welcomeScreenServiceProvider.notifier).saveUser(
          _usernameController.text,
        );

    _openLobbyScreen();
  }

  void _openLobbyScreen() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (context) => const LobbyScreen(),
      ),
    );
  }

  String _getRandomRewardText() {
    final random = Random();
    return _rewards[random.nextInt(_rewards.length)];
  }
}
