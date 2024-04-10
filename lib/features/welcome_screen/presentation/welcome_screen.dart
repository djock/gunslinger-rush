import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gunslinger_rush/features/common/data/logger_service.dart';
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

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  void _onUsernameChanged(String value) {
    setState(() {
      _isButtonEnabled = value.length >= 3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ref.watch(welcomeScreenServiceProvider).when(
              data: (user) {
                if (user != null) {
                  Future.delayed(const Duration(seconds: 3), () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (context) => const LobbyScreen(),
                      ),
                    );
                  });

                  return Text('Welcome back ${user.name}!');
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Who goes there?',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 16),
                      CupertinoTextField(
                        controller: _usernameController,
                        onChanged: _onUsernameChanged,
                        placeholder: 'Enter your username',
                      ),
                      const SizedBox(height: 16),
                      CupertinoButton(
                        child: const Text('Start Game'),
                        onPressed: () =>
                            _isButtonEnabled ? _onSetUsernamePressed() : null,
                      ),
                    ],
                  );
                }
              },
              error: (error, stackTrace) => Text(error.toString()),
              loading: () => const CupertinoActivityIndicator(),
            ),
      ),
    );
  }

  void _onSetUsernamePressed() {
    ref.read(loggerServiceProvider).e('message');
    ref.read(welcomeScreenServiceProvider.notifier).saveUser(
          _usernameController.text,
        );

    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => const LobbyScreen(),
      ),
    );
  }
}
