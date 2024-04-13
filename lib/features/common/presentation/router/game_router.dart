import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gunslinger_rush/features/common/domain/player.dart';
import 'package:gunslinger_rush/features/common/presentation/router/screens.dart';
import 'package:gunslinger_rush/features/lobby/presentation/lobby_screen.dart';
import 'package:gunslinger_rush/features/pvp/domain/game_data.dart';
import 'package:gunslinger_rush/features/pvp/presentation/pvp_game_screen.dart';
import 'package:gunslinger_rush/features/welcome_screen/presentation/welcome_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'game_router.g.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

@riverpod
class GameRouter extends _$GameRouter {
  @override
  GoRouter build() {
    return GoRouter(
      navigatorKey: rootNavigatorKey,
      initialLocation: Screens.welcomeScreen,
      routes: [
        GoRoute(
          path: Screens.welcomeScreen,
          builder: (context, state) => const WelcomeScreen(),
        ),
        GoRoute(
          path: Screens.lobbyScreen,
          builder: (context, state) => LobbyScreen(
            player: state.extra! as Player,
          ),
        ),
        GoRoute(
          path: Screens.pvpGameScreen,
          builder: (context, state) => PvPGameScreen(
            gameData: state.extra! as GameData,
          ),
        ),
      ],
    );
  }
}
