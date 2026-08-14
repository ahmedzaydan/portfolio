import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../extensions/context_extension.dart';
import '../../../../utils/custom_url_launcher.dart';
import '../../../../utils/size_manager.dart';
import '../../../data/models/icon_model.dart';
import '../../../data/models/projects_model.dart';

class PorojectAvailableStores extends StatelessWidget {
  const PorojectAvailableStores({required this.project, super.key});

  final ProjectModel project;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 4.w,
      children: [
        if (project.playStore != null)
          Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: StoreBadge(
                iconModel: project.playStore!,
                label: 'Play Store',
              ),
            ),
          ),
        if (project.appStore != null)
          Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: StoreBadge(
                iconModel: project.appStore!,
                label: 'App Store',
              ),
            ),
          ),
      ],
    );
  }
}

class StoreBadge extends StatelessWidget {
  final IconModel iconModel;
  final String label;

  const StoreBadge({required this.iconModel, required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedFillButton(
      onPressed: () => CustomUrlLauncher.launch(iconModel.url),
      iconBuilder: (color) =>
          SvgPicture.asset(iconModel.path, width: 24.w, height: 24.h),
      label: label,
    );
  }
}

class AnimatedFillButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Widget Function(Color color) iconBuilder;
  final String label;

  const AnimatedFillButton({
    required this.onPressed,
    required this.iconBuilder,
    required this.label,
    super.key,
  });

  @override
  State<AnimatedFillButton> createState() => _AnimatedFillButtonState();
}

class _AnimatedFillButtonState extends State<AnimatedFillButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fillAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fillAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onHover(bool isHovered) {
    setState(() {});
    if (isHovered) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final cyanColor = context.colorManager.primary;
    final whiteColor = context.colorManager.onPrimary;

    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onPressed,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            buildButtonContent(Colors.transparent, cyanColor),

            Positioned.fill(
              child: AnimatedBuilder(
                animation: _fillAnimation,
                builder: (context, child) {
                  return ClipRect(
                    clipper: _FillClipper(_fillAnimation.value),
                    child: child,
                  );
                },
                child: buildButtonContent(cyanColor, whiteColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButtonContent(Color bgColor, Color fgColor) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: fgColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 2.w,
        children: [
          widget.iconBuilder(fgColor),
          Text(
            widget.label,
            style: context.textStyles.label.regular.copyWith(color: fgColor),
          ),
        ],
      ),
    );
  }
}

class _FillClipper extends CustomClipper<Rect> {
  final double fillFraction;

  _FillClipper(this.fillFraction);

  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(0, 0, size.width * fillFraction, size.height);
  }

  @override
  bool shouldReclip(_FillClipper oldClipper) {
    return oldClipper.fillFraction != fillFraction;
  }
}
