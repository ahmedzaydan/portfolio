import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../extensions/context_extension.dart';
import '../../../utils/size_manager.dart';

enum RevealDirection { leftToRight, bottomToTop }

class Section extends StatefulWidget {
  const Section({
    required this.title,
    required this.child,
    super.key,
    this.direction = RevealDirection.leftToRight,
  });

  final String title;
  final Widget child;
  final RevealDirection direction;

  @override
  State<Section> createState() => _SectionState();
}

class _SectionState extends State<Section> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final Animation<Offset> _slide;
  late final Animation<double> _scale;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    );

    _opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.7, curve: Curves.easeInOut),
      ),
    );

    final offset = switch (widget.direction) {
      RevealDirection.leftToRight => const Offset(-0.15, 0),
      RevealDirection.bottomToTop => const Offset(0, 0.15),
    };

    _slide = Tween<Offset>(begin: offset, end: Offset.zero).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.8, curve: Curves.easeOutQuart),
      ),
    );

    _scale = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 1.0, curve: Curves.easeOut),
      ),
    );
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction > 0.1 && !_isVisible) {
      setState(() => _isVisible = true);
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) => SliverToBoxAdapter(
    child: VisibilityDetector(
      key: Key(widget.child.hashCode.toString()),
      onVisibilityChanged: _onVisibilityChanged,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) => FadeTransition(
          opacity: _opacity,
          child: SlideTransition(
            position: _slide,
            child: ScaleTransition(
              scale: _scale,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 40.h,
                children: [_buildTitle(context), widget.child],
              ),
            ),
          ),
        ),
      ),
    ),
  );

  IntrinsicWidth _buildTitle(BuildContext context) => IntrinsicWidth(
    child: Column(
      spacing: 12.h,
      children: [
        Text(
          widget.title,
          style: context.textStyles.heading.medium.copyWith(
            color: context.colorManager.onSurface,
          ),
        ),
        Container(height: 2.h, color: context.colorManager.primary),
      ],
    ),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
