import 'package:cocoflutter/components/shared/colored_text.dart';
import 'package:flutter/material.dart';

class AnimatedText extends StatefulWidget {
  final Offset startPosition; // Start position for x, y coordinates
  final int pointsGained;
  const AnimatedText(
      {required this.startPosition, required this.pointsGained, super.key});

  @override
  State<AnimatedText> createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _positionAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    // Tween to move the text upwards
    _positionAnimation = Tween<Offset>(
      begin: Offset(widget.startPosition.dx, widget.startPosition.dy),
      end: Offset(widget.startPosition.dx,
          widget.startPosition.dy - 100), // Moves up 100 pixels
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // Tween to animate opacity (from visible to invisible)
    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    // Start the animation
    _controller.forward().then((_) {
      // Optionally, remove the widget from the tree after the animation
      // Use a callback to notify parent to remove the widget
      if (mounted) {
        setState(() {
          // Animation complete
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Positioned(
          left: _positionAnimation.value.dx,
          top: _positionAnimation.value.dy,
          child: FadeTransition(
            opacity: _opacityAnimation,
            child: ColoredText(
              '+${widget.pointsGained}',
            ),
          ),
        );
      },
    );
  }
}
