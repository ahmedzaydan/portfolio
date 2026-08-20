import 'package:flutter/material.dart';

import '../../../../extensions/color_extension.dart';
import '../../../../extensions/context_extension.dart';
import '../../../../utils/size_manager.dart';

class SkillItem extends StatefulWidget {
  final String skill;

  const SkillItem({required this.skill, super.key});

  @override
  State<SkillItem> createState() => _SkillItemState();
}

class _SkillItemState extends State<SkillItem> {
  bool _isHovered = false;

  void _onHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cyanColor = context.colorManager.primary;
    final textColor = Color.lerp(
      context.colorManager.onSurface,
      cyanColor,
      0.2,
    )!;

    final padding = SizeManager.instance.conditionalValue(
      mobile: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      tablet: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
      desktop: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
    );

    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        transform: _isHovered
            ? Matrix4.diagonal3Values(1.05, 1.05, 1.0)
            : Matrix4.identity(),
        transformAlignment: Alignment.center,
        padding: padding,
        decoration: BoxDecoration(
          color: _isHovered
              ? cyanColor.withCustomOpacity(0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(100.r),
          border: Border.all(color: cyanColor, width: _isHovered ? 1.5 : 1.0),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: cyanColor.withCustomOpacity(0.4),
                    blurRadius: 16,
                    spreadRadius: 2,
                  ),
                ]
              : [],
        ),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          style: context.textStyles.label.regular.copyWith(
            color: _isHovered ? cyanColor : textColor,
            letterSpacing: 0.5,
          ),
          child: Text(widget.skill),
        ),
      ),
    );
  }
}
