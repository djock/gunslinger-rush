import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gunslinger_rush/features/common/presentation/theme/theme_build_context_extensions.dart';

class SlideableText extends StatefulWidget {
  const SlideableText({super.key, required this.text});

  final String text;

  @override
  SlideableTextState createState() => SlideableTextState();
}

class SlideableTextState extends State<SlideableText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    )..forward();

    _animation = Tween<Offset>(
      begin: const Offset(4, 0), // Start from the right side
      end: Offset.zero, // End at the center
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const FaIcon(FontAwesomeIcons.hatCowboy),
          const SizedBox(width: 8),
          Text(
            widget.text,
            style: context.textTheme.headlineMedium!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
