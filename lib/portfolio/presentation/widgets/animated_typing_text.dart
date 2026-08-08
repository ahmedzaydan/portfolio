import 'package:flutter/material.dart';

class AnimatedTypingText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final Duration duration;

  const AnimatedTypingText({
    required this.text,
    super.key,
    this.style,
    this.duration = const Duration(milliseconds: 100),
  });

  @override
  State<AnimatedTypingText> createState() => _AnimatedTypingTextState();
}

class _AnimatedTypingTextState extends State<AnimatedTypingText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _characterCount;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(
        milliseconds: widget.duration.inMilliseconds * widget.text.length,
      ),
      vsync: this,
    );

    _characterCount = StepTween(
      begin: 0,
      end: widget.text.length,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _controller.forward();
  }

  @override
  void didUpdateWidget(AnimatedTypingText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.text != oldWidget.text) {
      _controller.duration = Duration(
        milliseconds: widget.duration.inMilliseconds * widget.text.length,
      );
      _characterCount = StepTween(
        begin: 0,
        end: widget.text.length,
      ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _characterCount,
      builder: (context, child) {
        final String visibleString = widget.text.substring(
          0,
          _characterCount.value,
        );
        return Text(visibleString, style: widget.style);
      },
    );
  }
}
