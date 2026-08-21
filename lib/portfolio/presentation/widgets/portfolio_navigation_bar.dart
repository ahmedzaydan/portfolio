import 'package:flutter/material.dart';

import '../../../extensions/color_extension.dart';
import '../../../extensions/context_extension.dart';
import '../../../utils/size_manager.dart';
import '../../utils/sections_enum.dart';

class PortfolioNavigationBar extends StatefulWidget {
  final Map<SectionsEnum, GlobalKey> sectionKeys;

  const PortfolioNavigationBar({required this.sectionKeys, super.key});

  @override
  State<PortfolioNavigationBar> createState() => _PortfolioNavigationBarState();
}

class _PortfolioNavigationBarState extends State<PortfolioNavigationBar> {
  SectionsEnum _activeSection = SectionsEnum.about;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: widget.sectionKeys.entries.map((entry) {
      final isActive = entry.key == _activeSection;
      return _NavItem(
        title: SectionsEnumHelper.getTitle(entry.key),
        isActive: isActive,
        onTap: () {
          setState(() => _activeSection = entry.key);
          if (entry.value.currentContext != null) {
            Scrollable.ensureVisible(
              entry.value.currentContext!,
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeInOut,
            );
          }
        },
      );
    }).toList(),
  );
}

class _NavItem extends StatefulWidget {
  final String title;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.title,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final color = widget.isActive
        ? context.colorManager.primary
        : (_isHovered
              ? context.colorManager.primary.withCustomOpacity(0.7)
              : context.colorManager.onSurface);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: _isHovered ? 1.1 : 1.0,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutBack,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: widget.isActive
                  ? context.colorManager.primary.withCustomOpacity(0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Text(
              widget.title,
              style: context.textStyles.label.regular.copyWith(
                color: color,
                fontWeight: widget.isActive ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
