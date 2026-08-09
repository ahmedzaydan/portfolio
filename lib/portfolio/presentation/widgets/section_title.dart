import 'package:flutter/material.dart';

import '../../../extensions/context_extension.dart';
import '../../../utils/size_manager.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({required this.title, required this.child, super.key});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colorManager.surfaceContainerLow,
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 80.h, horizontal: 24.w),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: context.textStyles.headlineMedium?.copyWith(
                  color: context.colorManager.onSurface,
                ),
              ),
              SizedBox(height: 12.h),
              Container(
                width: 40.w,
                height: 2.h,
                color: context.colorManager.primary,
              ),
              SizedBox(height: 40.h),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
