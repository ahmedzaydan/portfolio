import 'package:flutter/material.dart';

import '../../../extensions/context_extension.dart';
import '../../../utils/size_manager.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({required this.title, required this.child, super.key});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IntrinsicWidth(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                title,
                style: context.textStyles.heading.medium.copyWith(
                  color: context.colorManager.onSurface,
                ),
              ),
              SizedBox(height: 12.h),
              Container(height: 2.h, color: context.colorManager.primary),
            ],
          ),
        ),
        SizedBox(height: 40.h),
        child,
      ],
    );
  }
}
