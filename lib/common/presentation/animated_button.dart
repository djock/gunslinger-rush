import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnimatedButton extends StatefulWidget {
  const AnimatedButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.isButtonEnabled = true,
  });
  final Widget child;
  final VoidCallback onPressed;
  final bool isButtonEnabled;

  @override
  AnimatedButtonState createState() => AnimatedButtonState();
}

class AnimatedButtonState extends State<AnimatedButton> {
  bool _isButtonScaled = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: _isButtonScaled ? 0.9 : 1.0, // Adjust the scale factor as desired
      duration: const Duration(
        milliseconds: 200,
      ), // Adjust the animation duration
      child: Consumer(
        builder: (context, ref, child) {
          return GestureDetector(
            onTapDown: widget.isButtonEnabled
                ? (_) {
                    setState(() {
                      _isButtonScaled = true;
                    });
                  }
                : null,
            onTap: widget.isButtonEnabled
                ? () {
                    widget.onPressed();
                  }
                : null,
            onTapUp: widget.isButtonEnabled
                ? (_) {
                    setState(() {
                      _isButtonScaled = false;
                    });
                  }
                : null,
            onTapCancel: widget.isButtonEnabled
                ? () {
                    setState(() {
                      _isButtonScaled = false;
                    });
                  }
                : null,
            child: widget.child,
          );
        },
      ),
    );
  }
}
