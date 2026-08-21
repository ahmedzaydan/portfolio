import 'package:flutter/material.dart';

import '../../../../extensions/context_extension.dart';
import '../../../../utils/size_manager.dart';
import '../../../data/models/skills_model.dart';
import '../../../data/portfolio_data_source.dart';
import '../section.dart';
import 'skill_item.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final skills = PortfolioDataSource.skills.skills;

    return Section(
      title: 'Skills',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 32.h,
        children: skills
            .map((category) => _SkillCategoryWidget(category: category))
            .toList(),
      ),
    );
  }
}

class _SkillCategoryWidget extends StatelessWidget {
  final SkillModel category;

  const _SkillCategoryWidget({required this.category});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16.h,
      children: [
        Text(
          category.category,
          style: context.textStyles.title.medium.copyWith(
            color: context.colorManager.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        Wrap(
          spacing: SizeManager.instance
              .conditionalValue(mobile: 10, tablet: 6, desktop: 4)
              .w,
          runSpacing: 12.h,
          children: category.items
              .map((skill) => SkillItem(skill: skill))
              .toList(),
        ),
      ],
    );
  }
}
