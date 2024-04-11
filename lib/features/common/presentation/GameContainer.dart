import 'package:flutter/cupertino.dart';

class GameContainer extends StatelessWidget {
  const GameContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/grunge-paper-background.jpeg'),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}
