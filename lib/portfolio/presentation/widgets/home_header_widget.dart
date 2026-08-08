import 'package:flutter/material.dart';

import '../../../extensions/color_extension.dart';
import '../../../extensions/context_extension.dart';
import '../../../utils/size_manager.dart';
import '../../data/portfolio_data_source.dart';
import 'animated_typing_text.dart';

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const personalInfo = PortfolioDataSource.personalInfo;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              spacing: 8.h,
              children: [
                Text(
                  'Hello, I am',
                  style: context.textStyles.titleLarge?.copyWith(
                    color: context.colorManager.onSurface,
                  ),
                ),
                AnimatedTypingText(
                  text: personalInfo.name,
                  style: context.textStyles.headlineMedium?.copyWith(
                    color: context.colorManager.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                AnimatedTypingText(
                  text: personalInfo.title,
                  style: context.textStyles.titleMedium?.copyWith(
                    color: context.colorManager.secondary,
                  ),
                ),
                AnimatedTypingText(
                  text: "Your partner to create a tech solution",
                  style: context.textStyles.titleMedium?.copyWith(
                    color: context.colorManager.onSurface,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 16.w),
          _Avatar(avatar: personalInfo.avatar),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.avatar});

  final String avatar;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: context.colorManager.primary, width: 1.w),
        boxShadow: [
          BoxShadow(
            color: context.colorManager.primary.withCustomOpacity(0.3),
            blurRadius: 15.r,
            offset: Offset(0, 5.h),
          ),
        ],
      ),
      child: CircleAvatar(radius: 100.r, backgroundImage: AssetImage(avatar)),
    );
  }
}
