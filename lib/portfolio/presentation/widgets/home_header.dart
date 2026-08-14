import 'package:flutter/material.dart';

import '../../../extensions/context_extension.dart';
import '../../../utils/size_manager.dart';
import '../../data/models/personal_info_model.dart';
import '../../data/portfolio_data_source.dart';
import 'animated_typing_text.dart';
import 'contact_info.dart';
import 'responsive_layout_builder.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutBuilder(
      mobile: (context) => const _MobileLayout(),
      tablet: (context) => const _TabletLayout(),
      desktop: (context) => const _DesktopLayout(),
    );
  }
}

class _DesktopLayout extends StatelessWidget {
  const _DesktopLayout();

  @override
  Widget build(BuildContext context) {
    const personalInfo = PortfolioDataSource.personalInfo;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(flex: 7, child: _TextBlock(personalInfo: personalInfo)),
        SizedBox(width: 80.w),
        Expanded(
          flex: 2,
          child: Align(child: _Avatar(avatar: personalInfo.avatar)),
        ),
      ],
    );
  }
}

class _TabletLayout extends StatelessWidget {
  const _TabletLayout();

  @override
  Widget build(BuildContext context) {
    const personalInfo = PortfolioDataSource.personalInfo;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(flex: 7, child: _TextBlock(personalInfo: personalInfo)),
        SizedBox(width: 40.w),
        Expanded(
          flex: 3,
          child: Align(child: _Avatar(avatar: personalInfo.avatar)),
        ),
      ],
    );
  }
}

class _MobileLayout extends StatelessWidget {
  const _MobileLayout();

  @override
  Widget build(BuildContext context) {
    const personalInfo = PortfolioDataSource.personalInfo;

    return Column(
      children: [
        _Avatar(avatar: personalInfo.avatar),
        SizedBox(height: 48.h),
        const _TextBlock(personalInfo: personalInfo),
      ],
    );
  }
}

class _TextBlock extends StatelessWidget {
  final PersonalInfoModel personalInfo;

  const _TextBlock({required this.personalInfo});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedTypingText(
          text: personalInfo.name,
          style: context.textStyles.display.regular.copyWith(
            color: context.colorManager.primary,
          ),
        ),
        SizedBox(height: 16.h),
        AnimatedTypingText(
          text: personalInfo.title,
          style: context.textStyles.heading.regular.copyWith(
            color: context.colorManager.onSurface,
          ),
        ),
        SizedBox(height: 24.h),
        AnimatedTypingText(
          text: personalInfo.marketingText,
          style: context.textStyles.body.regular.copyWith(
            color: context.colorManager.onSurface,
          ),
        ),
        SizedBox(height: 48.h),
        Wrap(
          spacing: 16.w,
          runSpacing: 16.h,
          children: [
            ElevatedButton(onPressed: () {}, child: const Text('Download CV')),
            OutlinedButton(onPressed: () {}, child: const Text('Open CV')),
          ],
        ),
        SizedBox(height: 48.h),
        const ContactInfo(),
      ],
    );
  }
}

class _Avatar extends StatelessWidget {
  final String avatar;

  const _Avatar({required this.avatar});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutBuilder(
      mobile: (context) => Container(
        width: 80.r,
        height: 80.r,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 1.w, color: context.colorManager.primary),
        ),
        padding: EdgeInsets.all(2.r),
        child: CircleAvatar(backgroundImage: AssetImage(avatar)),
      ),
      tablet: (context) => Container(
        width: 160.r,
        height: 160.r,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 1.w, color: context.colorManager.primary),
        ),
        padding: EdgeInsets.all(4.r),
        child: CircleAvatar(backgroundImage: AssetImage(avatar)),
      ),
      desktop: (context) => Container(
        width: 260.r,
        height: 260.r,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 1.w, color: context.colorManager.primary),
        ),
        padding: EdgeInsets.all(8.r),
        child: CircleAvatar(backgroundImage: AssetImage(avatar)),
      ),
    );
  }
}
