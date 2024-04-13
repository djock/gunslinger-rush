import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gunslinger_rush/common/domain/player.dart';
import 'package:gunslinger_rush/common/presentation/theme/theme_build_context_extensions.dart';

class GameParticipant extends ConsumerWidget {
  const GameParticipant({
    super.key,
    required this.player,
    required this.livesLeft,
  });

  final Player player;
  final int livesLeft;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: 150,
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            player.name,
            style: context.textTheme.displayLarge!.copyWith(
              fontFamily: 'Carnevalee',
              fontSize: 32,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                livesLeft >= 1
                    ? FontAwesomeIcons.solidHeart
                    : FontAwesomeIcons.heart,
                color: livesLeft >= 1
                    ? context.colorScheme.error
                    : context.colorScheme.primary,
                size: 40,
              ),
              Icon(
                livesLeft >= 2
                    ? FontAwesomeIcons.solidHeart
                    : FontAwesomeIcons.heart,
                color: livesLeft >= 2
                    ? context.colorScheme.error
                    : context.colorScheme.primary,
                size: 40,
              ),
              Icon(
                livesLeft == 3
                    ? FontAwesomeIcons.solidHeart
                    : FontAwesomeIcons.heart,
                color: livesLeft == 3
                    ? context.colorScheme.error
                    : context.colorScheme.primary,
                size: 40,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
