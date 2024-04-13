import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gunslinger_rush/common/presentation/router/game_router.dart';
import 'package:gunslinger_rush/common/presentation/theme/game_theme.dart';

class Game extends ConsumerWidget {
  const Game({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(gameRouterProvider);

    return MaterialApp.router(
      onGenerateTitle: (context) => 'Gunslinger Rush',
      debugShowCheckedModeBanner: false,
      theme: gameTheme,
      routerConfig: router,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler:
                MediaQuery.textScalerOf(context).clamp(maxScaleFactor: 1.7),
          ),
          child: SafeArea(
            top: false,
            child: Scaffold(
              body: child,
            ),
          ),
        );
      },
    );
  }
}
